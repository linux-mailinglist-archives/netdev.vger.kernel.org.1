Return-Path: <netdev+bounces-268485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL1sOiQOuWk/ngEAu9opvQ
	(envelope-from <netdev+bounces-268485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 09:17:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 601C62A569D
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 09:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4109B3006F00
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 08:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60BE304BBC;
	Tue, 17 Mar 2026 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QGUueo6q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EB038F633
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773735458; cv=none; b=Wr1CmtPpv0P8xUrkCk08e2MvaAAFpE4hwCzcocXP0UKeV1tfySlqDpmbRCV6t09PpEIDUi8pYQ+9IM35xzvLE2HgBcOUeU/nhG0v7CxpF21VxdQQF6dxBJmuFRyl70iI75x2PdMJuIZJvkrjWlSTFbp2cC6w2DI0jXlm9oGiZnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773735458; c=relaxed/simple;
	bh=RizAMFm8qv0Wk6Zk23XPapCdUf6SdeqsLPoxJYXww64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKIPJaMowNVxLMAWWpR+PQF15OSSaUq35k43Jl0uFiAjdR3hYxzcg/AyxZdybbbbK367wlDyFG6+5i/bJ8WZ/co8sCLnLhmEC4oIFtA3AmT6vPPpPhJMW2MF+ImMv+l8do6pZeEcPqB+k5gHWkTDqM58VPBntVLoV3YFBxvdG30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=QGUueo6q; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4853aec185aso44577905e9.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 01:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773735453; x=1774340253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o2UwsW0WUcUoVz50RsyxFiaWiEDpEQN4GwEjH3zfjWc=;
        b=QGUueo6qE/69bLJyQ/+4g18wy+40yYqQij6JwbRvRLjn5nQAMmXK5lRpEwFc68LzfD
         mZk7FvTa6PLoJD1O7a+35XEaio/sHyhKu26zdce9X7hUp8cc2eHx+ehQDXBv+FPzBOof
         EzDVwrfOFcwqfkdWo26t33iKYK0AailaA7zus/EbqGZa+JE+vXJul6v3gD63QrC4KFPA
         6aVjdkmvdpL6nKuKc45UVXJa2tz6vRXiD+xNpe7x+tro6NLmd4UdqxjaYlx5apCbp/2M
         znfeD5LncUXJvqYmNtJVAsofWd6qp96PXSRpRuE/l8kZDueAOC19fFExHLgBqPLG2h5z
         UHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773735453; x=1774340253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2UwsW0WUcUoVz50RsyxFiaWiEDpEQN4GwEjH3zfjWc=;
        b=cnFv60dwDtdg6cyfXaOfT7cx0+eDZcBMaeKhAAiAkT3HE1gzoKrP6OXqXi3OkrxGLA
         9J/hcPRnE4yv8vDFH4uUWbfD/SZw2Ct0hwLCkAgY7eG4qQH0kOMjgwqq9MFSkKIIVSQ4
         3w0PFnMbLb+SWs17B4vn85JqyeenAH+ffcHhTZRrxEjmJOSg0MFYtZjTYcY0bVfZArOd
         VOH4oIjWQvk0qvlE2/xNLWfqEH/DXyAR5Y5h8sjfpeXVZZ+ZxVZeRBdQQtKz9h+jQ5sV
         XG8ZsU8gmlWfat4KkWHY8E5+geedfhnLU1m8DAHPKHdtP/0lYfRnt5ls/24cGHVOpxYs
         VwTA==
X-Gm-Message-State: AOJu0Yz2xUovyU81/I130dILeiWMqmWtclcOvRheX7p5pGuj02vxbBbW
	AIKFV3DzdJ6jvSNs5tHZHKYaWBywRFlSR13j/PcZ+HziQ2a/YPgIT0O//Sq6MhI9iPaCrF9fIs5
	qLmQY1do=
X-Gm-Gg: ATEYQzw+4uEv82IrD7yuReqPQxilu+EZKSef+ffOqmWrljn3k3xIAngxI48REzVzsYP
	37tKUgZcXywlvNbPLOiwiQeWzcavNxmAz1gajlsS6GnYxZQPHh30d8BGJx83QUCTQmPLisuG4IX
	+1xV4o/wxMf0w/SCJAKaFDZdCUEO7p5GMJROIE3fhtvirWgklFH6HVOuKkTeiij4pg9W2I/6xhb
	dE9VVhF2ofc6VUwSyVqnNf5cn54MuWLdfUmeswKjbyA3GoJWEAZ/XXagaENWciObH7cNFllnAIq
	1l0E/hPc3CX6ysRAXeabsU9LthTBK5+nn3FQVEiXvIkSn+1DPAD1M4oEVUjNvKt75OK8ms5brWQ
	OQGrzauU11GQjRjirjfiWGlVNUzvn/rvQ/dyKdKyYsvkGwEKndgTiG2ufehdgflgaeNxFsHSI5P
	HZmv/fDlcTDjDMOFFZJy1xStuQZH/xHGD0MwsQ3b0iymI=
X-Received: by 2002:a05:600c:8488:b0:477:a1a2:d829 with SMTP id 5b1f17b1804b1-485566d5162mr255287795e9.13.1773735452954;
        Tue, 17 Mar 2026 01:17:32 -0700 (PDT)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:81f8:c391:4972:647b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b42bd696dsm16511521f8f.37.2026.03.17.01.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 01:17:32 -0700 (PDT)
Date: Tue, 17 Mar 2026 09:17:30 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, dsahern@gmail.com
Subject: Re: [PATCH iproute2-next 2/3] mnl: add fallback implementation for
 mnl_attr_get_uint()
Message-ID: <z4jw6f4asfzbvlxad7owwws7zwfns4gi2k56bmnfb4c6t2dbm2@4wrw7nals4r6>
References: <20260316154418.625026-1-jiri@resnulli.us>
 <20260316154418.625026-3-jiri@resnulli.us>
 <20260316091245.05ac89fe@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316091245.05ac89fe@phoenix.local>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268485-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber.org:email,resnulli-us.20230601.gappssmtp.com:dkim,netfilter.org:url]
X-Rspamd-Queue-Id: 601C62A569D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mon, Mar 16, 2026 at 05:12:45PM +0100, stephen@networkplumber.org wrote:
>On Mon, 16 Mar 2026 16:44:17 +0100
>Jiri Pirko <jiri@resnulli.us> wrote:
>
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> libmnl introduced mnl_attr_get_uint() to handle NLA_UINT
>> variable-width attributes. Add a configure check to detect it
>> and provide a fallback implementation for older libmnl versions.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>
>How far back was this? If it was relatively recent would
>prefer not adding another set of config tests.

https://git.netfilter.org/libmnl/commit/?id=102942be401a99943b2c68981b238dadfa788f2d

I'm not sure what you suggest as alternative...

