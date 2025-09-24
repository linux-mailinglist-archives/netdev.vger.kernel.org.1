Return-Path: <netdev+bounces-225886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D07B98E1C
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70CE1884E86
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A9128850B;
	Wed, 24 Sep 2025 08:26:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1567028751A
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702384; cv=none; b=FLvZO7s9xZ/m5heNiDzjJ0IqYSVQ6AnvUfCQNyTIp9puVMKpPmiLSj8+YGFAZtpkSF19KZSKeHqPOCh7HdzBoLyAPljhY7XXVjOLJ0mVM/o+ppJSOKt3iVJx5oagI8Ge1vZgDt+tdphE7qiaS1c0dzetgQOp+JGTUyAQEiKPnlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702384; c=relaxed/simple;
	bh=+tUrgkxN/lp2KXqz828oyBVZ2yDGNOIKK7iRndNRB/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BngSDnuj83LgsUzFk/opdSCvrcxQClhdtgtDvVbefSGhRjNXfGxJ3etztSR1YmA2hWLz4UD+lA8aYBucOYAqVETdY/8Fgx4yJFTy5IEjf8/1JzIOGpoomNCJEVzeKBp53CJcpAWOF9C1dgml5gtQD7X/VNundig5V39ue+Gdj4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-631df7b2dffso1588532a12.1
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 01:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758702379; x=1759307179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZeXGQPLJ237ts6pnuqslfPixY1clqbR+lLUJqF8pM0=;
        b=hoTGh4OP3g2lz48ZeXr/tg6jVRd7/q+NL6MYDBgjIZQRdrjVxQammeqpXCXXKHAhNN
         AFBJ/03ZDul9Qj80ftXUQgJCMTExsPGRgW4szc/14T2neDlIJUC0jHa1a9W4Hc0uEfDR
         5zoo5Lby14t9ezuLtR6I4edYEBbnRsdCuYcursOFc37uwQXpFquQOFH8BPPcePPuhZ2n
         hmN+9iKw+88Tt/S5pM21Y8ps3bCv+1OASO/tXcetbSLR1twyzW7t6hBOyVOMeaLKO2Ga
         aIcwEU4Z8AlgEO0cd7idh6wMXr4S9uNMhscd+FCt4Oz4k6p8LQ9EjZ3WXSI8hvJgyBC1
         5MvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDqPnvy/V05o5axAAhXOc1aX3DDkMatsbn1/nLc4FbxTc5cr+at2kKqXjT0U6s3I5BPYP32aE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFZLauEb4p6tl6qvJlNd3IGncY/rSehxMLmcdNocCa0RV0/w09
	O06fxq0NZWR38yujEJ6YsqFgl5a3KqGI3qb3npNaR+Gz37dsQmSzTvkc
X-Gm-Gg: ASbGncsnNvNSuyHalmyh1eWbHZPIl61h/jEJjCQxPs8MgtanYcBR7aLKvPgV4+vWa9l
	irWcuBMy4QGvVf4LlCBR7zXE/el43tbY7KYpN1dSMrjLBeEaxsuumjR1Zio6L7NagHEcqVBJpHu
	ltANcHx+aUQFbIgbxxaQuPNGfl55DLdnYvGHMWSEyNqIf5QDmll3kOOG0fRRtRPwdZUFMsx7ZBK
	ugEDWN9Xi7fJ2OKI7q0aoPiDrTDMSw335JkJvYJ9/23SCNqk2SWlrWLiANoXY3zFL/WH/Uk381+
	kKSuk0it3uSrtPsJCDr5N1YxTLm/HniOx8OF0bLDnWyihJOToe+McpfO4WhS5tnCHRiYkq9qmbs
	MX01WxHA49QyRlg==
X-Google-Smtp-Source: AGHT+IFvEGn77kjtA6Y8SK5uc34FRU7qFYS3L/ZCPGwLjDFkpKGYZCp8QtLrY/o9FuB9JVbNkzTzQQ==
X-Received: by 2002:a05:6402:50ce:b0:627:f96f:aa7b with SMTP id 4fb4d7f45d1cf-634839a09a0mr1588732a12.7.1758702379165;
        Wed, 24 Sep 2025 01:26:19 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5cfa60dsm12473716a12.4.2025.09.24.01.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 01:26:18 -0700 (PDT)
Date: Wed, 24 Sep 2025 01:26:16 -0700
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] netconsole: resume previously
 deactivated target
Message-ID: <aukchuzsfvztulvy4ibpfsw7srpbqm635e24azpcvnlgpmqxjm@e4mm3xoyvnu7>
References: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
 <20250921-netcons-retrigger-v2-5-a0e84006237f@gmail.com>
 <t32t7uopvipphrbo7zsnkbayhpj5vgogfcagkt5sumknchmsia@n6znkrsulm4p>
 <4evp3lo4rg7lh2qs6gunocnk5xlx6iayruhb6eoolmah6qu3fp@bwwr3sf5tnno>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4evp3lo4rg7lh2qs6gunocnk5xlx6iayruhb6eoolmah6qu3fp@bwwr3sf5tnno>

Hello Andre, 

On Tue, Sep 23, 2025 at 08:30:39PM +0100, Andre Carvalho wrote:
> On Tue, Sep 23, 2025 at 05:22:25AM -0700, Breno Leitao wrote:
> > For targets that are set by the mac address, they don't necessarily get
> > np.dev_name populated, do they?
> > 
> > I am double checking netpoll_setup(), and if
> > is_valid_ether_addr(np->dev_mac), I don't see np.dev_name being
> > populated.
> 
> I was not expecting it to be the case either, bu my understanding is that 
> np.dev_name does get populated by __netpoll_setup, which is called unconditionally 
> at the end of netpoll_setup. __netpoll_setup eventually does:
> 
> np->dev = ndev;
> strscpy(np->dev_name, ndev->name, IFNAMSIZ);
> 
> I've confirmed that for targets bound by mac, np->dev_name is empty before these
> lines but then it is correctly populated here. For targets create by name,
> np->dev_name is already correctly set prior to this. 
> Please, let me know if I'm missing something.

Thanks for confirming it. I think this might cause some semantics
confusion for the user, given it is asking it to bind to mac, and later,
netconsole is binding by dev_name.

Let's say the following case:

 1) netconsole is configured to bind to mac X which happens to be on eth0.
 2) there is a PCI downstream failure which causes a re-enumeration
 3) netconsole will get DEACTIVATED during phase 2
 4) After the re-enumeration, eth0 becomes some other and interface (not
 the one with mac X).
 5) Now you are going to bind do eth0 which is not the one with mac X.

> > Should we also compare that the mac doesn't match before returning?
> 
> Even though the above seem to work on my tests, I was not 100% sure we wanted
> to also check the dev_name when we initially bound by mac.
> I've also considered the approach below, which I think achieves what you are
> suggesting:
> 
> if (!is_broadcast_ether_addr(nt->np.dev_mac)) {
> 	if(memcmp(nt->np.dev_mac, ndev->dev_addr, ETH_ALEN))
> 		return;
> } else if (strncmp(nt->np.dev_name, ndev->name, IFNAMSIZ)) {
>         return;
> }
> 
> Let me know if you prefer this approach, it would allow resuming targets in case
> even if their dev_name changes.

I would prefer this approach than the current one, this would avoid the
problem above.

The other option is to always populate the mac during netpoll setup and
then always resume based on mac. This seems a more precise resume.

In this case, if the device goes to DEACTIVATED, then np.dev_mac will be
populated, and you only compare it to check if you want to resume it.

