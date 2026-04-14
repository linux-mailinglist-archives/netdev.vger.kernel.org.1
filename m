Return-Path: <netdev+bounces-278294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MW3NGvX3WlLkAkAu9opvQ
	(envelope-from <netdev+bounces-278294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 07:58:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0DF3F5D4D
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 07:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AA79303DAE3
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 05:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8B2330B01;
	Tue, 14 Apr 2026 05:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="IlYL07JT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA9732863D
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 05:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776146267; cv=none; b=W3b+xmY4S3zcUv4CUgHipCq0RxIwcgbyxgeURDj3K++1VwRfnO7AFjFw/jiXAgbN4Elk/JJtG4KrvPgwF9xe+TFbC20Xm6zMOKXmzywyE3oSbOkEQqKa0JH6zFyNjnh2QYgHXJQhhVzSbjjPcBhAGj+idsnUJIvnrFB0ZV4BmQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776146267; c=relaxed/simple;
	bh=fL1BQiE78C/VjXgZjz0I/OnikJU0sOr8cHQ8lfspUXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M/+em4qNBdPfT0NMVOmj5XsvgmO4HiYicuONHoCUphc/vdjnb3T6pl+YVsuj00F1RXZziWTDNjLLBqDeFefmo+yZ2PlTYOdAyuS+fxELwwdyKEf88KR0+raROZvrO1MRLgi5lLYmTQ4r3V3jh3kpW9LjkDtt+4X8Bmz7/sqBit8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=IlYL07JT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so69079455e9.2
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 22:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1776146263; x=1776751063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J3FVWDcNHvJ+MdKdZ4uMKyGaVsr5qzyvfvQ9LJ0YzWs=;
        b=IlYL07JTob5h3gLQqb8UzP4KAxwyO76hdbiEvfoQWgRgTaOA3gggIOVEwWWlYZu4I1
         ev8P8ZMclHQjH5TUJTVty05X6cf6YJ0vJmFH4cl5aWZUasGdEQVPuuzCfnNT/wG9YMvA
         wauI6DjKpzpl4/5fbKmhZ7u0MMYEz7qqUJ/Dwah9efzWgMS6dIFc4sEKZTEjpboqklYL
         MiFDd+lvt+761Tt0+GJi2/r/lqW6s7BZXHAnTyxnl8W8QuvOYb2gOhViiQUDC4rdpS+m
         7UKbEuhVc9XTqpqsez4rtTwiFAmPc7NRWBOuX69BC7QERladeJto5HDQAVM5sbWxT5/M
         c/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776146263; x=1776751063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3FVWDcNHvJ+MdKdZ4uMKyGaVsr5qzyvfvQ9LJ0YzWs=;
        b=mhi7IrJIdUH/ewa7fvykt6//d98Q6AIzOSbbRJAItq8GiSVouGm7ZEWy5ML1viwVbS
         AlDvvJR8dnn6x/7qzCtNzfBldBXNbCWawTf5cFrHx7Yo22ZRUwY2UPQ2nhsCxBAufdmx
         j04qYurTaLZJgPtbcfqSuldO170lttZfv+UcCJ6gnH1I6MNp+FSbS5fY/mzhifjg481/
         7Hk1jmqROpuu/EIS2q+EH19YDUrfuGvohukC77JBdXjc6hWy7pJHCBPPwRjlXlVPiKS4
         CCLW+Z9WgWXoBD9fDXxdVdekJkDBjrCQNRHr3kSOyLFpKvnRX+YB4uDkMq+Adc6nIedl
         PMiA==
X-Forwarded-Encrypted: i=1; AFNElJ+ftXwFBOhscGbpUBKjuaHpae4RoV6dsfsWsJOIeYj58uovhvN0puBdJzJNyg3tLyN3mxQd+Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMHyE4Ijv7vQKwdf70Pwl7QSjURqM+oPCZuE9Er8L69BbVYE1w
	XyhP41ZQqT3miOxOoP4I6l2BNF16DJNwBil00FFJCgEksJMkudKaTW9cUiA3nhkOszwLs0mTH6V
	moUYO
X-Gm-Gg: AeBDietH9wwkogQtQ32+ayKB3h8EYbsFcPwdlgO6bORtzQME0W8jkCJt+/GaacC+VmZ
	wMDtgqQduJ0F7+MoyQ0fR62QIxEOqthmyap7tCKjhHgY/jAEh+eiV7ZYUTrk+1wtJnNcGuw7NI0
	MpeuRQ+nM9UHFz+Q1fS9H3Gn0itVVr0JWL47RCbIMT4cNirNsBdRdUC3cj4sgj0BPlmb4NUzSfM
	1mgGZ3wv41fXtIDoNR8kR2Gf1jNkYfzEBnDWT30A0l3sHppihwuBd7jmzkbaZOD6LwGVnJy+p+7
	GZBwzU4NfxLWf919gdkE3A+IRF014oxrPccHZsMp0EcpHEcaw6iidhtaXLbWXCZPRfpxmbve+HW
	vVE9rteMIUCQ1p1Prem406/jK/YT3wiuDHD0Cj7tUMbTfS4YWOHIePqnKxeFoVpH0/RF0KgX3tO
	ag5HGYWHWhF9INqHoOeQzB8U1XOovwzALq7o65QJn6BB89MSR0Bd43s0A=
X-Received: by 2002:a05:600c:348d:b0:486:ff92:63e5 with SMTP id 5b1f17b1804b1-488d67df5aamr230013235e9.6.1776146263404;
        Mon, 13 Apr 2026 22:57:43 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ecde5b26sm33037035e9.2.2026.04.13.22.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 22:57:42 -0700 (PDT)
Message-ID: <836b5855-320e-495e-b17c-a5c027fc0c1e@blackwall.org>
Date: Tue, 14 Apr 2026 08:57:41 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] tools/ynl: Make YnlFamily closeable as a
 context manager
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: kuba@kernel.org, dw@davidwei.uk, pabeni@redhat.com
References: <20260413220809.604592-1-daniel@iogearbox.net>
 <20260413220809.604592-2-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260413220809.604592-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-278294-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A0DF3F5D4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/26 01:08, Daniel Borkmann wrote:
> YnlFamily opens an AF_NETLINK socket in __init__ but has no way
> to release it other than leaving it to the GC. YnlFamily holds a
> self reference cycle through SpecFamily's self.family = self
> in its super().__init__() call, so refcount GC cannot reclaim
> it and the socket stays open until the cyclic GC runs.
> 
> If a test creates a guest netns, instantiates a YnlFamily inside
> it via NetNSEnter(), performs some test case work via Ynl, and
> then deletes the netns, then the 'ip netns del' only drops the
> mount binding and cleanup_net in the kernel never runs, so any
> subsequent test case assertions that objects got cleaned up would
> fail given this only gets triggered later via cyclic GC run.
> 
> Add an explicit close() that closes the netlink socket and wire
> up the __enter__/__exit__ so callers can scope the instance
> deterministically via 'with YnlFamily(...) as ynl: ...'.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  tools/net/ynl/pyynl/lib/ynl.py | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
> index 9c078599cea0..f63c6f828735 100644
> --- a/tools/net/ynl/pyynl/lib/ynl.py
> +++ b/tools/net/ynl/pyynl/lib/ynl.py
> @@ -731,6 +731,16 @@ class YnlFamily(SpecFamily):
>              bound_f = functools.partial(self._op, op_name)
>              setattr(self, op.ident_name, bound_f)
>  
> +    def close(self):
> +        if self.sock is not None:
> +            self.sock.close()
> +            self.sock = None
> +
> +    def __enter__(self):
> +        return self
> +
> +    def __exit__(self, exc_type, exc, tb):
> +        self.close()
>  
>      def ntf_subscribe(self, mcast_name):
>          mcast_id = self.nlproto.get_mcast_id(mcast_name, self.mcast_groups)

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


