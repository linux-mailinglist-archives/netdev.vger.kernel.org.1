Return-Path: <netdev+bounces-134614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB9899A6E0
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 16:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141BC285EFC
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 14:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18F119412E;
	Fri, 11 Oct 2024 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STq8YSyz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DB7154C1E;
	Fri, 11 Oct 2024 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658213; cv=none; b=QM5k5P6xDusaBZed63idVksLk7DCEnILsc5ucU3MqXgIcpR59B5togv4euGApIDfWh252Smv6UlXhjfXwvILp1mpndEVFd+iSMPEVD3ZrIrn83bAAFeYuExl4IfZILQhWOAUze5CqW67wGAOAPZOkhZbaPE4g30c3c/742qMD/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658213; c=relaxed/simple;
	bh=g1BejgMxHi8WOL6Nwz5uzME1vA5rJHB3mKEaFaO4T8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKZOBSwj5fapi73ce3yRJwZJzYBi5dngJ3o425p2NHYHmkh3XGKSNvzTsaB4Xjc2/o9lrwqr1FceFZ9HJNKVMKyQ4UfQRAbYIn6liUH3eFKS/mskb2fEQunH57BYOhs64m/iFtGm6TnGysHMGOOXCEHq9jn04VMtIBLvgSp2spU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STq8YSyz; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7db637d1e4eso1572800a12.2;
        Fri, 11 Oct 2024 07:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728658212; x=1729263012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lwD/IxPjshg8sSRjxJ9nFSNy7cm9zyZxLj39yIl5YQc=;
        b=STq8YSyz7KD5cQxG2mxlRjeYGJms2hT9gJGB4vZTyABbbWe8aqKTHPEh6p6EUZijbY
         NBIHogRJ8cAP3pSXEzmj48oqXV0mp6V2mg/ykz+R/jog+Lwwrjlo9cw2+W6zyCCRKmQH
         QqX8vJxW7+wZCovNTLDkGeY7F3VhravX8N5RoL3Z3sRl526dfO808L4s9xGuImncBlLW
         INiNs5DMc1BcIGe7KsNoRuUmyK7PgjBChE6U0rXtWLadjMaFo/7eokgkpqcHt78Cul89
         RCRu9/sr5LFkApMiF84YHTKbNjbGH5i0pARqXjMAt/tlPrwBS5k8Xqr2xSpuacoppagQ
         d5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728658212; x=1729263012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwD/IxPjshg8sSRjxJ9nFSNy7cm9zyZxLj39yIl5YQc=;
        b=qePmz0uPd8j5EAdYE2W/OMedXGaK4lbgC2PGrucZIgySovA91p5DjJkURqXtftfwb7
         spXob4NBv/4Ax9tkquE4IB5cxKclQd1NUJR389aN+R7eWzuXND/M2DfkKXL2cYhIbT+5
         2J7xmUqKLqyCnmt0chay5hXNkieP2xKHVGeEYlkxPkO6NNkWQ1SBkp9K/wjcatOw5H7i
         uyzG0Le/w7DTFKF1NrGqaL8JteMRZtCWStbKIAiH6vbHiUP5doxzr1aQxkmw4xikBg8w
         Oz1ryIysH7ZjrE/HbQj+s6FiR5ZBs0t9cBAH7G4Sh0so95vnMSo+lAwVhxeiHvsJ5Gng
         LS7w==
X-Forwarded-Encrypted: i=1; AJvYcCW914bunVY3oOIgUUaRdmuQaNuhwvjL2koQ1/mwb3QDLfN4+WaGj/XOSTgkn/gnG+xX8y3aMi3aZnkTtRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxBtJCE2CnSlMWnas31/EODkBpuh2rHvC9DQarQY20oix5DQd0
	7cr19CyasptWOZBPWcdtzS4yN1ZcK0lOTirxzFSbWXEmzMXHllI=
X-Google-Smtp-Source: AGHT+IEV58zeyrV8J5giw7NLuSrTCxdHOlRif/CN+n4wGv4pU8yCB+XqFHdLqeKJ6QAyl936SFuovA==
X-Received: by 2002:a05:6a21:2d86:b0:1d4:fcd0:5bea with SMTP id adf61e73a8af0-1d8bcf00ccdmr4711937637.6.1728658211212;
        Fri, 11 Oct 2024 07:50:11 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea448e4147sm2605282a12.5.2024.10.11.07.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 07:50:10 -0700 (PDT)
Date: Fri, 11 Oct 2024 07:50:10 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net-next 3/3] selftests: rtnetlink: update netdevsim
 ipsec output format
Message-ID: <Zwk7IjfSjWw7thjw@mini-arch>
References: <20241010040027.21440-1-liuhangbin@gmail.com>
 <20241010040027.21440-4-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010040027.21440-4-liuhangbin@gmail.com>

On 10/10, Hangbin Liu wrote:
> After the netdevsim update to use human-readable IP address formats for
> IPsec, we can now use the source and destination IPs directly in testing.
> Here is the result:
>   # ./rtnetlink.sh -t kci_test_ipsec_offload
>   PASS: ipsec_offload
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Thank you!

