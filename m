Return-Path: <netdev+bounces-298356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9ZBgFSUjK2qh3AMAu9opvQ
	(envelope-from <netdev+bounces-298356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:05:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A34546755CE
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:05:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=multikernel-io.20251104.gappssmtp.com header.s=20251104 header.b=OWhyqt0a;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298356-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298356-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F295333E8C1D
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4A34DC535;
	Thu, 11 Jun 2026 20:59:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC174DC523
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 20:59:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781211546; cv=none; b=aP5tp78mz1biIWpydETFEUKgSp86VVtFQkxhzgROgR0Srix/FScePNXEYRUkV5AZBVjgkHSSud8KFGJ56zWyPBraovjsISAoxXh3kTFCwkKPQ+3pJVvlDls13syXmILGRTS/KuTluI8SrFfjbYEumR8jzKsJbe3Tfw1N1fSl7oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781211546; c=relaxed/simple;
	bh=XJ+ja/54XWFissrUkUu3n9x2odHK0qJ+G6SKeMvhhvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhqvZmnwuClbKBgT4t7VzMMc6A03DRU00hyxo7hbD1aObanwhxONxfDTFyvIBcOg03KS1eBw9TNM795GM754A+4g+DXGa2ZA0TRG9p2LpFTrOjunh8yVqdlKPDb8APE94R96WrC3MWx59N75awnrq+Ip0GOfTJuVGHjKeH5qFho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b=OWhyqt0a; arc=none smtp.client-ip=74.125.82.171
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-307d0405e07so482209eec.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 13:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20251104.gappssmtp.com; s=20251104; t=1781211543; x=1781816343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MUGEJTphEZFGdBsrL1Ap3pgZRMiQ/Bb3HajFXRKP6PA=;
        b=OWhyqt0apsb5ldefUQUx0QDXAeUCvu828Usuw4DYmK7mnUs1hf0w4Bp/OGBSxip9as
         25BF4piEcq7qlQvwAgcuID8W0ZwuO01+rORm94NkPF6NvdVOKPX9uJD3EoxhMpNCyuY6
         BiHXM7mulpSEwGvatodRJtVmNnEJqpGuwKDsep2XmhYwAvC/xGZ8cfkGxs8NeQtoEcE6
         vio/Ppk6wMh9y1odvbZoweuX8Ic/wALtDaV2IbzkCo/8Nwt3DhITXbvf8pPaPeP/w3sW
         xxf3YMsNkQCDTLOFAJLfpA7QKeH6AbQfA9T0APFzzK+8lwCRIkfFRfauaBElKIBQQGPb
         k3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781211543; x=1781816343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUGEJTphEZFGdBsrL1Ap3pgZRMiQ/Bb3HajFXRKP6PA=;
        b=ZvNNbCh4CnEWAKSG2TPMmgZBTRDH8Ym32qSnrcorvU5floDGdSn0olNoweTu9hmxd3
         pj4DIbVZUXTbP6LcWOIsRx1ySiwR2tKvsBaC2RHcxj8E7Gbcq8Liu1MKgsvVTXWzd29b
         tD9lP2ecTrjvCY84wAZota+o1NJ/4qePw4kwOgDTwU0gpZ8OX4Ke16/3jHIRp+QSTnSK
         FtSuWTgubZWjjf/zhXC3lLiXXkWmdMEFtI409gEXVbrrxDexKMiGXPTXGOLRGkA/Y5/S
         HTA0pPKfNRSG8f/SRo3a+vpkMLLp6ObxDr6aITlUU/nJtqiTi0/pyrBmmY8SM880O9R6
         85CQ==
X-Forwarded-Encrypted: i=1; AFNElJ+dv+RH8NUB3Rf3In+GFYo//u2e6CetoJAje3Y5z3HA/PAdf6ktkER9oBucOZY6PnTFsq3b3xE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPSKH+tcQS9mRnIJbLsUjOH47ntyj+eYxehyBO9MKtv6g76Ddw
	YadlhPMjANshUIUPRBHTuWK6CrH7ZmuhejaidzcPZRoU13amweS5I2mU3YsCWdvT+ig=
X-Gm-Gg: Acq92OEJVMirc98mzxy8R7WGtOjKxY+D6mnpsK6EKJ9Z7yKL0XgSsEKYIdzs/UYfu+S
	jQMcaJY7egY5gCBxKO8UATaFyiZplXxn8Ov6v7yQnqguhtUjRBN29mxBjvGAJiV3Gdm1qx3eeO4
	xtub/GS3JBrAfZIxX++m9xPjSRhRrxRm449cfjMn1Vje/UK2I6OMqxMit7fM1sAWRhH/GxNU4ze
	IEVahJwQVChTuA/kuWueuwtZD33Ip0YiJ4h9ReP0Qhv2f1yih4ON392BGnRPbXCgXgMkEmNSmNY
	tEewHXv1yY8wVFk20IeOj+9W1YTeem/7H5pdiVPDD73rJKjdM3ElBuDKbKtd4yP7ySIIVrYJ+Xo
	i8OiYbz73e6E74EJqiRxy4u4K7VhJZ0SVH+ILr0ChatdVbwmQPYUDe79PlV2oyKekGv4IeOK/l5
	Qf/ynEgZxExSIQHj7jUBMYsRkhFwqWnPlee0SbPHn0FdCjsv6sMWPF0Q==
X-Received: by 2002:a05:7300:2393:b0:304:b93a:511a with SMTP id 5a478bee46e88-30804b8d667mr3459122eec.28.1781211542621;
        Thu, 11 Jun 2026 13:59:02 -0700 (PDT)
Received: from localhost ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0828sm416981eec.10.2026.06.11.13.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:59:02 -0700 (PDT)
Date: Thu, 11 Jun 2026 13:59:00 -0700
From: Cong Wang <cwang@multikernel.io>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Shuah Khan <shuah@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Cong Wang <cong.wang@bytedance.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v2 0/7] bpf, skmsg: some fixes for skmsg
Message-ID: <aishlHQXerhy6Mio@pop-os.localdomain>
References: <20260611123538.156005-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611123538.156005-1-jiayuan.chen@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[multikernel-io.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298356-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[multikernel.io];
	FORGED_SENDER(0.00)[cwang@multikernel.io,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:bpf@vger.kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:martin.lau@linux.dev,m:ast@kernel.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jakub@cloudflare.com,m:shuah@kernel.org,m:hawk@kernel.org,m:ihor.solodrai@linux.dev,m:rhkrqnwk98@gmail.com,m:cong.wang@bytedance.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,iogearbox.net,gmail.com,fomichev.me,linux.dev,kernel.org,etsalapatis.com,davemloft.net,google.com,redhat.com,cloudflare.com,bytedance.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cwang@multikernel.io,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[multikernel-io.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,multikernel-io.20251104.gappssmtp.com:dkim,multikernel.io:from_mime,pop-os.localdomain:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A34546755CE

On Thu, Jun 11, 2026 at 08:34:08PM +0800, Jiayuan Chen wrote:

Please wait for 24 hours before re-posting, this time you only waited
for about 11 hours:

	Date: Thu, 11 Jun 2026 09:35:43 +0800

For your reference, this is the rule in
Documentation/process/maintainer-netdev.rst:

```
tl;dr
-----

 - designate your patch to a tree - ``[PATCH net]`` or ``[PATCH net-next]``
 - for fixes the ``Fixes:`` tag is required, regardless of the tree
 - don't post large series (> 15 patches), break them up
 - don't repost your patches within one 24h period
 - reverse xmas tree
```

Regards,
Cong

