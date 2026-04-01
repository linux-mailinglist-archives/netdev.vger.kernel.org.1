Return-Path: <netdev+bounces-273798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Eq1MrtpzGlXSwYAu9opvQ
	(envelope-from <netdev+bounces-273798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 02:41:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EC037338E
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 02:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 381FC3009576
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 00:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300881B4223;
	Wed,  1 Apr 2026 00:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZLVdXlZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38B01A680C
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 00:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775004088; cv=none; b=VhMUyeA0xcys56ziER5ZRuE9Gsf1HuoDfGqI9WtcaxrkP2jqxhnZ9Z5XqjFw6gXI/r8lULKOjwbgiVWOv0hp9EAlOQPl6rodqzSCL44BXCSi8mIOmY8CkrylUW6M+zxNHMHuODjODZtiDyt+pchqhqsm7TIv+pXXtA+u9NL+05o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775004088; c=relaxed/simple;
	bh=k15qr5bFq1kXFV3bPI/a5fnwulbjc61G4OSeVCSCg48=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gowdfkzMsmnFyIVYupNhxKOXSfXK9m1sLG6NozOszS5zdGJi02bMnX/l4sW0gXNvecye1/vRQaYKyRqp3/xlmpwjqP588nJc17QilUNXB0ez+/JvhCJzhKbuyxzT0jjkMbmTP1JAcgChuIueN8Fq+d5c8cF4TtG6mJjTrlk/5HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZLVdXlZ; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12732e6a123so2366928c88.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 17:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775004086; x=1775608886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k15qr5bFq1kXFV3bPI/a5fnwulbjc61G4OSeVCSCg48=;
        b=ZZLVdXlZ2gyPFX9uzH2VKKaN2wIXuGkZFvzmFVMoo3DOT17aQIAwHociZIr+N7OhvC
         CXRIzJIPugfKaDa0VofDqET0RGPMKMiQ0XtlBBOYlkGJ9KqB1GFrVxMYYYyodYiabu2s
         0f2s1yZnD/cE64foGFLdBaDxKfSJJhG/GunHXBb/bCQM+/z6r2qQBMknvEI0WrGHzi81
         FzTbGEXo6FrASyWigh6MSOaU3bEuGmeACie9fxkHDpZRNKzkf5S0GUlAoEgwCR3EJP78
         RbnOtQhAblRa7EZ3WnPBIb3VHp4j0yINTldXiiiNNBjMVbT9L/vFWmwOKi1NOvmGtgil
         27bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775004086; x=1775608886;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k15qr5bFq1kXFV3bPI/a5fnwulbjc61G4OSeVCSCg48=;
        b=qrpdI3HbcUYmliz06jiJIvNkZ/eupZpoJZXoyUDIiI6jKG9UAQ48+tXryl8/0O20iT
         gqHjCksjoaPqZpHGxGcVIQAqieLUbx956JCLJO+WWSFLiKWaNPCiEtaCr5zhBuFUNpxK
         AudsHoweBaX06rg4W0khjzLey+fQHMyBHMfw4xaWJyqikARR1+HsTm5jfmYcdR1wE/yq
         2DEm/53XaoE3+foFSDpQa4v+sNNkX9hJRIQOXI9oBAZc2KbcsOd1yf4CAqqOUnVbBFyd
         IaEuf14YWyZA2ojU2GYTFg7XzYvOnoay6XInZhahkRvYA0jl4jnEyVPBbmaiXo5dCjxi
         F5DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQZR4bO8hi6h8kB2J3fcTwCOl93a0brO37q2JftyrfI6f7OBLf+JAbo2qcqAiWuIu/06up7F8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3MfOKzoaq6PQ59lGjTNxWCGPvyJsDpLrl0VrqHuZYkbsVoR0A
	DkfOoN+ZioZi0Jr9JU9X2a+upTpw4eSEiB2cy160GCzv5tItYzuEXqpw
X-Gm-Gg: ATEYQzxu7FJ8yHMoiiORGR0+MBT6Bi2kgqAyo6u6tnZmbHg6VVQHGzBNsyOmKic3wYF
	+/QvIrTAdfaTt/zevTaUT5pdx0phhRsDL92Q3WAFYjCcd8Bj+wskoH+DUHmLpcPU6kt3Fg9YIL3
	mGDYIinjnqYzJ43HjIdudU2Ct2Piutir2Ma6+/cDZGDafOvOy9uLKRJ2VOxiXAbUMm+zU2aNjou
	pYsgWLciMpMW61r+afRqnr42wpKG9CwoTj0BjWin/8GnALieAaRSUGcWut1TZmAH4+7/dfYjZfS
	bpgbfv4wDrW1hgHUNdmvCAG7CJpd7aEu8c7rPKySwvgziXCcQ1XEFg1og2pZ9VvzTwE/+RQIiP7
	cPyZRZjGqBcLU4E00KFWyKUG1rbYwQvnxAL9ACXOAMyxd5+JVUjJxZMJSaa6fBnAI0Vsqk+FD55
	RXdDDpTcuhN850ne9wVAI0jCGmfa7cHi0ZtVHl
X-Received: by 2002:a05:7022:4398:b0:128:d2b3:5df with SMTP id a92af1059eb24-12be64db363mr970380c88.23.1775004085670;
        Tue, 31 Mar 2026 17:41:25 -0700 (PDT)
Received: from [10.0.0.2] ([169.235.25.186])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97cb08csm18574623c88.3.2026.03.31.17.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 17:41:25 -0700 (PDT)
Message-ID: <4631f54a-bcc8-454b-9355-15a21f9e1e21@gmail.com>
Date: Tue, 31 Mar 2026 17:41:17 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: yuantan098@gmail.com, security@kernel.org, netdev@vger.kernel.org,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, afaerber@suse.de, mani@kernel.org,
 yoshfuji@linux-ipv6.org, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 bird@lzu.edu.cn, enjou1224z@gmail.com, zcliangcn@gmail.com
Subject: Re: [PATCH 1/1] net: ipv6: flowlabel: defer exclusive option free
 until RCU teardown
To: Eric Dumazet <edumazet@google.com>, Ren Wei <n05ec@lzu.edu.cn>
References: <cover.1774855883.git.zcliangcn@gmail.com>
 <07351f0ec47bcee289576f39f9354f4a64add6e4.1774855883.git.zcliangcn@gmail.com>
 <CANn89iJ+pDwKy0kKKG8PrSWMXEStgsMP9YGLxwvjcmMJP1PwrA@mail.gmail.com>
From: Yuan Tan <yuantan098@gmail.com>
In-Reply-To: <CANn89iJ+pDwKy0kKKG8PrSWMXEStgsMP9YGLxwvjcmMJP1PwrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,davemloft.net,redhat.com,suse.de,linux-ipv6.org,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-273798-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuantan098@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Queue-Id: 45EC037338E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/31/2026 1:52 AM, Eric Dumazet wrote:
> On Tue, Mar 31, 2026 at 1:34 AM Ren Wei <n05ec@lzu.edu.cn> wrote:
>> From: Zhengchuan Liang <zcliangcn@gmail.com>
>>
>> `ip6fl_seq_show()` walks the global flowlabel hash under the seq-file
>> RCU read-side lock and prints `fl->opt->opt_nflen` when an option block
>> is present.
> Some points :
>
> Please do not CC security@ if you submit a public patch, there is
> absolutely no reason for it.
>
> Please do not resend the same version within 24 hours; this creates noise.
> Your patch wasn't lost; we have many patch reviews and similar bugs to address.
>
> Thank you.

We sincerely apologize for the confusion caused by our previous email. Previously, when we sent reports and patches to the security list, we were advised that patches should be submitted to netdev@ for public review. To follow this, we are now sending the full vulnerability details to security@ while additionally submitting the patches to netdev@. Please let us know if this is the correct way to handle such cases.

Regarding the CC list, could you provide further guidance on who we should include? Currently, we are CCing everyone suggested by get_maintainer.pl because we previously received feedback about missing relevant maintainers. For public mailing lists, we should only including netdev@. Should we be more selective?

Finally, regarding our tags, our team has a clear division of labor—some focus on finding vulnerabilities, others on fixing them, followed by an internal review and testing before a dedicated member handles community outreach.

We welcome any guidance and will improve our upcoming patches accordingly. To be honest, we are currently a bit uncertain about the exact workflow the community prefers, and we are eager to align our process with your expectations.


