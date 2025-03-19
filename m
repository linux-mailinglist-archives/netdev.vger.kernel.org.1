Return-Path: <netdev+bounces-176132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 423F2A68E6D
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 15:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C40C3AFB1C
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 14:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF4518C322;
	Wed, 19 Mar 2025 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b="UK/ZfTwD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D10170826
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742392958; cv=none; b=i1Sm0cycruOKPJ42W+Bmrl9iLBBWz3ZPx4E7SPM3W7bkoFVnKO2PjAjO+/2xYf9e77V9oSbhUluR/rIYV0p2ADMvi2G7/2dm0z550eZMc+WMoQhIgkeJISw0l5AMI68EOqpcGDhFV9BmehIkEu0uiA6k0efjM3f9QvAY9OT1FSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742392958; c=relaxed/simple;
	bh=VL0+bfmMWvoarK2YRsZLEvh7yoJMXfUOMscjws3zpU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rwHcTeE/CnTs5SlmcOL5iqE3R3fwLhx5OfIk2mqmArj/iE8EGEnm1kZbLxt1Jusb3FrrV82BgnUowl6Rw1EzRY4PHEkbV9X78ThZYEcMXIZdpDX1/sT9qxLiN5nQxCED52LnpSkwdHG33hU0FAJ+Oq0S6E5tW7ZWWW2lHYfzg0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net; spf=pass smtp.mailfrom=enfabrica.net; dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b=UK/ZfTwD; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enfabrica.net
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c3bf231660so47403385a.0
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 07:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1742392955; x=1742997755; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yqFdjXJJZDWctcOKPgqf7kjRIWslgFrCEm4t8yjHkyM=;
        b=UK/ZfTwDSUY2KzcEGZJWPhBApiM7OGOJC2WwUk6wzQYsKwHbm9q/HL6pC+VfEaeckV
         U5ylQgs0OhhwM4fYIWu6lmPuA/ynYGrmpjiTeAed8JcPqxyNzX9xQUOF0vAn1tX+GCr7
         AccB4svIEHz7ZV6oS0+tLan740bfSmhQDnzvikNrwcZ5UBri66eSrp17RawyD7Kp+kb8
         E2o0DOsYpo1RkWg0ZKWLzxR+wMQr2W3nR6PReZq4GWMF8iUX0fHu8n2UQRroNJrHy4Lz
         z+wW1K1RRHSKKzWyE0U8QeOKJbO3Xeq2sG7J6GnHnoGkHlGRG8NZ26Vu+UbxlCsEPiNu
         WsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742392955; x=1742997755;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yqFdjXJJZDWctcOKPgqf7kjRIWslgFrCEm4t8yjHkyM=;
        b=emg4+i5VYD2tLu78LKF21yb/qSEclE1R3Y9K2Wo9S7DE8R1pzkeSawLrCnONcxnYDR
         lKs56HPIzg6WF76QsZKuuHhdLeOHTAf5UyWOS35TK/cMZNIqPIg1nNcF9+2lrKXou6z4
         ZUIz5LQoyAd/6djTxrzvQS1Zs6rw5OYk72pjniSR9SQ1pRk7xyVBxeY3T/MGiA31T9lI
         5vQf91RMLKuKEv8fLhxQwjueuOoG1akbTigmP8kOSkUd+c2IBoPdFTP5KyLr63Z1/0WU
         hBTteg+HGEs8Ruq2TZOSp8QaYGwqosN67mKKPC0JzN3kZPZTb74yXROoO3niGuPmpFOV
         laTA==
X-Forwarded-Encrypted: i=1; AJvYcCXOshpEqxyNVma88DtB6c6ga4g1Rd3LS4WLAqn4dFN8Jm1EVMuFyyyMBneVT3UoGmNgfMUbhmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGJ5RcpNXWfykF8VNcIuYzLEkTLZU05+9O+tv11fe2HC3UubnK
	e8sVSIiwKyi3N3AYZ8jWvZ+gKKunnO+j1iDRgt7Ts3L5hEPNOFxE6Y/1FIf8b4c=
X-Gm-Gg: ASbGncta5YYdi6M4wzUU5yPYXXzKxMqvhsAebsFtZPJZjCUIk1mrMlkQ/h97T6nJdDD
	tuYWeCaIOvJY5x02UCYvgRESCCeD53Zl/8yDX3Exano3Z/eJtOTUzidCTh+eHgfcNI7KUGjjrGa
	Jb9AXdZVytpxF8VTrk41ZEkpI+K1hv8Qi+ES6VGMGfIZg4eJQvB+Ou3N4UdxyRr2KIUxAU4/oZ6
	JpeISz3xGD/GADOe2UdP+bCe2OxdIJ1xl73JavulXWQzqgHBG3oD/3SWq6t1TiOBirWIfsv8Hj9
	dnrkSuuxUqW4Di9MPouIfaQAP0JIqvvlPv6BaEN0DQvC1XG0+6NIl5hOZoLcvas2oZ7Qzd+5POL
	FOpA=
X-Google-Smtp-Source: AGHT+IFH1CyyTaTSujsVNE4WTfOFEQySzuZ9BFJP8uD15BKkwpL5DSioGr0yZTBXxYUP8nrEV84MQw==
X-Received: by 2002:a05:620a:4546:b0:7c5:4913:500a with SMTP id af79cd13be357-7c5a838ecc8mr297884085a.19.1742392955477;
        Wed, 19 Mar 2025 07:02:35 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c888117csm20774989f8f.44.2025.03.19.07.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 07:02:34 -0700 (PDT)
Message-ID: <62fbbcd4-e820-4ccc-aa63-c4f754b4c83c@enfabrica.net>
Date: Wed, 19 Mar 2025 16:02:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
To: Jason Gunthorpe <jgg@nvidia.com>, Bernard Metzler <BMT@zurich.ibm.com>
Cc: Leon Romanovsky <leon@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "shrijeet@enfabrica.net" <shrijeet@enfabrica.net>,
 "alex.badea@keysight.com" <alex.badea@keysight.com>,
 "eric.davis@broadcom.com" <eric.davis@broadcom.com>,
 "rip.sohan@amd.com" <rip.sohan@amd.com>,
 "dsahern@kernel.org" <dsahern@kernel.org>,
 "roland@enfabrica.net" <roland@enfabrica.net>,
 "winston.liu@keysight.com" <winston.liu@keysight.com>,
 "dan.mihailescu@keysight.com" <dan.mihailescu@keysight.com>,
 Kamal Heib <kheib@redhat.com>,
 "parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>,
 Dave Miller <davem@redhat.com>, "ian.ziemba@hpe.com" <ian.ziemba@hpe.com>,
 "andrew.tauferner@cornelisnetworks.com"
 <andrew.tauferner@cornelisnetworks.com>, "welch@hpe.com" <welch@hpe.com>,
 "rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
 "kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "kuba@kernel.org" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250308184650.GV1955273@unreal>
 <2f06a40d-2f14-439a-9c95-0231dce5772d@enfabrica.net>
 <20250312112921.GA1322339@unreal>
 <86af1a4b-e988-4402-aed2-60609c319dc1@enfabrica.net>
 <20250312151037.GE1322339@unreal>
 <BN8PR15MB25133D6B2BC61C81408D6FE899D22@BN8PR15MB2513.namprd15.prod.outlook.com>
 <20250319135236.GJ9311@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <nikolay@enfabrica.net>
In-Reply-To: <20250319135236.GJ9311@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 15:52, Jason Gunthorpe wrote:
> On Fri, Mar 14, 2025 at 02:53:40PM +0000, Bernard Metzler wrote:
> 
>> I assume the correct way forward is to first clarify the
>> structure of all user-visible objects that need to be
>> created/controlled/destroyed, and to route them through
>> this interface. Some will require extensions to given objects,
>> some may be new, some will be as-is. rdma_netlink will probably
>> be the right interface to look at for job control.
> 
> As I understand the job ID model you will need to have some privileged
> entity to create a "job ID file descriptor" that can be passed around
> to unprivileged processes to grant them access to the job ID. This is
> necessary since the Job ID becomes part of the packet headers and we
> must secure userspace to prevent a hijack or spoof these values on the
> wire.
> 
> Netlink has a major downside that you can't use filesystem ACL
> permissions to control access, so building a low privilege daemon just
> to do job id management seems to me to be more difficult.
> 
> As an example, I would imagine having a job management char device
> with a filesystem ACL that only allows something like SLRUM's
> privileged orchestrator to talk to it. SLURM wouldn't have something
> like CAP_NET_ADMIN. SLURM would setup the job ID and pass the "Job ID
> FD" to the actual MPI workload processes to grant them permission to
> use those network headers.
> 
> Nobody else in the system can create Job ID's besides SLURM, and in a
> multi-user environment one user cannot reach into the other and hijack
> their job ID because the FD does not leak outside the MPI process
> tree.
> 
> This RFC doesn't describe the intended security model, but I'm very
> surprised to see ultraeth_nl_job_new_doit() not do any capability
> checks, or any security what so ever around access to the job.
> 

It doesn't need to do any capability checking because it is defined in the YAML
model, there you can see flags: [ admin-perm ] so in the genl ops code that is
automatically generated we get .flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO
for these ops, which in turn means the genetlink code will check if the caller has
CAP_NET_ADMIN. The unprivileged process can request to associate with multiple jobs
and it's the privileged process that has to configure and control them. In this
version we have only configuration. Once the specs become publicly available we
will be able to share more information about how it's expected to work.

Cheers,
 Nik



