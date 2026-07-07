Return-Path: <netdev+bounces-305502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GdetGWUVTWovuwEAu9opvQ
	(envelope-from <netdev+bounces-305502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 17:04:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B05C571CF8C
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 17:04:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="CT0Xa/Uo";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305502-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305502-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2945334C09C
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 14:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCBD4252A2;
	Tue,  7 Jul 2026 14:33:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BA6426407
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 14:33:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434838; cv=none; b=g27oPEJJ6ZPA3dNMVKhIuYdQG5yHmdOcMnAfKl4RXa/Zhjt39L3cgGnlJSx9e0kTDbH5dKMgCsHgtfKH9+pDK5hW/i1gNn/YQvezdrXsTP6a+nEcO0/+dKXBfL9CmoEgrMPt+uLRnO+F2M9pSOnZyI4w6l+88GIk+X7Du6MQd0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434838; c=relaxed/simple;
	bh=uoaSrEaF2U/AwdaCa2IXOKZyAE7DXgSZdd87uQF3MPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnhJas7bR79W5CQs0n04YHLl8YuzpxQm3++JiTVyztf+MwQyA6+6H+sseRWTX/d+BPNzvOTRw63hFHxlKMQakDFa0xqRQ+JpASVifZLSIk6oF3mAGFWcLGJs1fCWnKuHM5DCz6HnEHSMoMijGEXMMUsrv8Mhza6jd4qUNKTzK4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CT0Xa/Uo; arc=none smtp.client-ip=209.85.210.174
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8478a25f268so3328681b3a.2
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 07:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783434836; x=1784039636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Co78LYEqO7Xq0HUigIABDWSc76R4xuWDdkk/ckElme0=;
        b=CT0Xa/UoYyRBYEyEY4ESNz4Qd5tLFFOloCHAFK0A4tuEdB3NwvQkzb0OvbNfpUW4Ri
         v7ntgu1QS4KtLA0AYevyjeR2BXQfW+i5X0PAItFlNJR1edmCIJqfpkM9m7TvTAk3Z33G
         hCNK7z/AlZXc/SfAe92RHJIvuELTJTTPEzz0hbBgyd3P7y8m4nddb8O0BoiaBRmtEtQT
         8tvoGRGt8KIy0jU1+Bchhom8n9azidOGh7FC/q0sE+GkQqK0GGf8hdBAZgqSKRDFJkzI
         VYmbM6P4ogAeFOzkoE1ndCG35ClyTyu5305XN2y1Y5ZmdeopBN3A/nUp4KrwcaeYuIjj
         dxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783434836; x=1784039636;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Co78LYEqO7Xq0HUigIABDWSc76R4xuWDdkk/ckElme0=;
        b=kW3wZ+VgjA8mCAvyDu/mCu4scCk2si5iBGpx/bVbZw5Q/ITi6vRXWbn9UYGTq0jlJQ
         autjwT9d0MQh5re5uStTtVvhGxPW+c/1jMdkapj4gudtFEJpRMTjXrwv53P3wRDLlaG2
         xSSvHo4Ko/MvIQjnObkyWC6A54rYUOwagFj8nttqFYg8NGCx/95uSk9PO0RRIQw6VSBP
         SZ1vTUCK+hpMKiJeZ+OsmR5pLLNJU1NY9th9Wybflzx47Kg/W/dtBmqvs4Zxkrv2yS3j
         FSglF3eaaQrjY15WRW+xacghbKfn3c+tO33G3fxqLpdZHPm5yr+RuQdRBoqyZbk3lKvY
         +O7Q==
X-Forwarded-Encrypted: i=1; AHgh+RrPlNt6usMxXI3brVorG9POvG1/fnq8uAt6gyf5i4zQH+LlzlOIkRw/bfUssZC0OXpqWPpPjls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1KE5BZLvnD/JF5Pe6x/EvhXiuHpcDnaGaOzX1jXwWiiCd0ElK
	9pr2TFjETaiZjv1aT9w441AbP5WNRJDz9t1UObiKXMMRFYAm8yKQYZ4d
X-Gm-Gg: AfdE7cm2BzWQ2AwlxKqMOGi1/j/fu4g7pgrxnXA+rhKskofBJSysBzDzuE+NdqHbBLh
	Oq3226PeXmTgQ5qQq75l23Z08RKUJjfOf37zqVo1k7V5eKPEtnK99NetL55WhqfaWc48u0VsAHo
	cU+3d7oOUtS8KLzLTstYVVThEfCHDCmFfCVnCqriG0v8/U8nQ3Zw0nobFdzUb79m6RASuba0RWh
	69ov0SMDBtOrh/wvdZUT9jkGIILfaYB8/R/aPYvucYaz2Z/dp/Yz9j5JPjEavAOczR0/bSt2ZuB
	bUV7TM6IqqPuWduwGuyx0p2BXA9icQKC4MDFpFRiyX+tsoAA26SOZ2/3otW8x2LJFaN177EiTxF
	kiM7XrKqG/HOB4HkghA/O5+ULMrol+F6pyTh+QwxeMJRS1uW//vzz+3VS6mKPR7YaONz/xoWmhR
	oJfRpLdRiCUw==
X-Received: by 2002:a05:6a00:2c87:b0:842:4f20:53ff with SMTP id d2e1a72fcca58-84826d98971mr5346111b3a.42.1783434836558;
        Tue, 07 Jul 2026 07:33:56 -0700 (PDT)
Received: from john-p8 ([98.97.43.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d7a96fsm5539485b3a.46.2026.07.07.07.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 07:33:55 -0700 (PDT)
Date: Tue, 7 Jul 2026 07:33:54 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Mattia Meleleo <mattia.meleleo@coralogix.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	"jakub@cloudflare.com" <jakub@cloudflare.com>, jiayuan.chen@linux.dev
Subject: Re: bpf, sockmap: FIONREAD returns 0 for TCP sockets in a sockmap
 without a verdict program
Message-ID: <ak0NXYLSMqi-HH72@john-p8>
References: <CAOvpEWN6xgFx4GWFnnWLGCB+_1auDcAZPYPSv1PDu3UfXkcriw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAOvpEWN6xgFx4GWFnnWLGCB+_1auDcAZPYPSv1PDu3UfXkcriw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mattia.meleleo@coralogix.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305502-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,john-p8:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B05C571CF8C

On Fri, Jul 03, 2026 at 06:10:16PM +0200, Mattia Meleleo wrote:
>Hi,
>
>in OpenTelemetry eBPF instrumentation we use a sockhash to track
>outgoing TCP sockets for trace context propagation. Sockets are added
>from a sock_ops program, and the map only has an sk_msg program
>attached on the egress side - there is no ingress verdict program.

This is how we use sockmap in many cases as well. I just haven't
rolled out any actual workload tests recently sadly. I expect we
would also hit this.

>
>Since commit 929e30f93125 ("bpf, sockmap: Fix FIONREAD for sockmap"),
>ioctl(FIONREAD) returns 0 for these sockets even though read() returns
>data. tcp_bpf_ioctl() answers from psock->msg_tot_len, which only
>accounts for bytes in ingress_msg. Without a verdict program, data
>never lands there: it stays in sk_receive_queue and is read through
>the tcp_bpf_recvmsg() fallback, so FIONREAD always reports 0.
>
>The commit message explains that sk_receive_queue is intentionally not
>counted because a verdict program may redirect or drop its contents.
>Without a verdict program, however, all of that data is readable, and
>applications that use FIONREAD to size their reads (nginx, Java, .NET)
>hang or truncate transfers once their sockets are in the map.
>
>Observed on mainline and on 6.12.75+, 6.6.128+, 6.18.14+.

agh because fixes tag it was backported everywhere :(

>
>Reproducer: https://github.com/mmat11/fionread-repro
>
>  pre-insert     FIONREAD=4096 (expect 4096) OK
>  in-sockhash    FIONREAD=0 (expect 4096) BROKEN
>  post-delete    FIONREAD=4096 (expect 4096) OK
>
>Is this intended for psocks without a verdict program? If not, would
>falling back to tcp_inq() (plus msg_tot_len) in that case be an
>acceptable fix? Happy to send a patch and test it.

Its a bug. It needs a fix. Please send a fix I'll review and
test on our dogfooding env as well. Would you also add a selftest
here so we can capture this behavior is fairly common for apps to
do this.

