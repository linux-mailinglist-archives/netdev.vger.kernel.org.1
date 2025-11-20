Return-Path: <netdev+bounces-240371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6DEC73E81
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 13:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DADA4E871F
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 12:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D093321AD;
	Thu, 20 Nov 2025 12:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QXlUGNMO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284B73314B8
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763640581; cv=none; b=es1BSVPlKAQqrHnj/PLceW+jgNSL+XPfnWIlrwds1JaEog4jwOhm3ZR8ZM5hx43BhO/4GriWl7FEgRR+ENJY2sSuCzfl9m4n07S3YnODmZJ5RIw5CeU4cFDTwr8xjf89hrxPP2+HdIV7+bQdKOHKD4ECGZ4BeAsuyYlrudn6oOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763640581; c=relaxed/simple;
	bh=gcVcD1n4ee+H1YDiuDfkt7Tr7JvAH4O988KQFKf1NXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ya6hRAv+B50a5uAhZ5BiSuoWu++WXbGqX20XJCOcw+ST41eFm0imrVI1rUv+gVfWENKkTdGNr0Mxl2Cp6BiEW22ROX7KwBrHB3dbAO4szF47ZPKAEKh7Eh+c7dFuPqHPlvU8/xESyCnOcQHrQNAXjcWPzBdbPSEDsnOfV1/4uj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=QXlUGNMO; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso1338042a12.3
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 04:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1763640577; x=1764245377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FWSnudDR8tHHtjamIlJX7lyfwtx5ChaAS1c4cXdDUyk=;
        b=QXlUGNMOAZa4DDK7sT7DIvtM2gFl3zuEU51lnz9Qg7Xl9Gbbl7m97JC7/vQuXbwtHT
         072pnzfDolVDKeloxN/YYM9/IpDOKMGoBQun8sltfZXdbLvZZrcZXmUw4rhI7ysGsPpc
         k2XMzUZGFB8roZImDyYt3ILdOtVpsxmXXnUvpFltDAAoTlDxzSyeEz3vdjhCjBvi4T2q
         JmIztNYwf15zPC8diHDTqrlIR9A7knnVA4rbVDR0p4dh+sxlrRk7LoOIlI22TmkFCNye
         /IU0P0lqa0VTAfUh7J+pDoMk27ppO4jiD6ohIAJeF81iX3wbcjFkeP2yY3JM7/XYm528
         S9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763640577; x=1764245377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWSnudDR8tHHtjamIlJX7lyfwtx5ChaAS1c4cXdDUyk=;
        b=nS4n9wyJrhYnzI8C4e8+ALBDtqH7cSu49Mqkx6CQ51Q6UMm0XzlbFp1dX44l8oX6BG
         trFRzBqx8R0OEUrWL6E7Rt3g0cq6hdqtr/4RGKyiU7RqOlvYOAb/m4xvgqpHmPQlPPRI
         gVf0oACxEzaT+yRGlart/fFwIPOCzqg6RjLZJCBQIaLqYsnbqpFa9bqtXRLeiYqWNwt1
         dMa+/yVo+pTouCMaChJxf/ynv0UnG4byE3TnK55wpX6LcGm/RBM0Ph70Wx+wxzymDkYH
         MV+SRStehNPIJEoPeg1hGECOHOjytfVmbQU4NMNPRZ80Gnj9y/qKr63maekRa8fX0wW4
         7qeA==
X-Forwarded-Encrypted: i=1; AJvYcCXuC5UE1qMxNQBpPRFuxY9zlenkoJ6wgYmd5QbQj/BZo1wpQeHAn8FCDVxnvceGEgcJ373KKWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZIKKM3YId4U1uP+5r9rrhZI/QIjb4DmI/ide63Objd6O3VBPz
	0TBzf/o5XmVaR4czuAcPbng/nC64drOxKBtz8rPgKjJHhtL6G7NyGNFIFK/AJlvb2uo=
X-Gm-Gg: ASbGncsCnDAS21E3ftFGu3tP+CYaaI3FGQTQT0DFTqRo/TGCzvxufTHNyuF37RPTYsP
	3I7CgpK0laRovMvgj4FPVmKGqq0XFsciA9prcZAP9jogAdgp/34YXP9Pzg22klaU7qCr8zhm0PW
	lBW+KpI6jx3I0xap62Odwse0U9dTiEbjK3QxGEsI8WxcvAkL3PAhBFcne8JxeOARklZEZBVYWeQ
	D6IbPo/iZ4FKaQp+HQMyNOUA6QfM9SRXOYZr2nAhyp9YZzJcZGG69vWOtRf2V1l49uoYrvw7vkd
	JVTHIGfYgZa1/0jFtW84sZ6fXKRLxeSqklHY05vQEMQDCIn1QnaDMjkKmOwTsq7cI0/LklPJcev
	VOIRkoJ3hj7r3Tbhc8dVewFG5NpAjshrekLAkJpqJfMe/kElTwoVqk7gk6OK2cGdJd0GPwgCC7s
	VcdSi+enbqztyilNFDhNs=
X-Google-Smtp-Source: AGHT+IHRDa6hk0aFCtsUQ00gc8HrkYKh8UMcKyJEbSS2aB1Hb6FdEjVNNaMmagQCJNwQfw+q4sMHmg==
X-Received: by 2002:a17:907:7f19:b0:b73:4e86:88ac with SMTP id a640c23a62f3a-b76554862d5mr292723466b.12.1763640577191;
        Thu, 20 Nov 2025 04:09:37 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b765504828esm188350466b.64.2025.11.20.04.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 04:09:36 -0800 (PST)
Date: Thu, 20 Nov 2025 13:09:35 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Parav Pandit <parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org
Subject: Re: [PATCH net-next v1] devlink: Notify eswitch mode changes to
 devlink monitor
Message-ID: <32hbfvtxcn3okpylfcgfeuq7uvrufpij4y7w6au6vxrernwthb@pdxvc6r6jl5z>
References: <20251119165936.9061-1-parav@nvidia.com>
 <20251119175628.4fe6cd4d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119175628.4fe6cd4d@kernel.org>

Thu, Nov 20, 2025 at 02:56:28AM +0100, kuba@kernel.org wrote:
>On Wed, 19 Nov 2025 18:59:36 +0200 Parav Pandit wrote:
>> When eswitch mode changes, notify such change to the
>> devlink monitoring process.
>> 
>> After this notification, a devlink monitoring process
>> can see following output:
>> 
>> $ devlink mon
>> [eswitch,get] pci/0000:06:00.0: mode switchdev inline-mode none encap-mode basic
>> [eswitch,get] pci/0000:06:00.0: mode legacy inline-mode none encap-mode basic
>> 
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>
>Jiri, did you have a chance to re-review this or the tag is stale?

Nope, I reviewed internally, that's why the tag was taken.


>I have a slight preference for a new command ID here but if you
>think GET is fine then so be it.

Well, For the rest of the notifications, we have NEW/DEL commands.
However in this case, as "eswitch" is somehow a subobject, there is no
NEW/DEL value defined. I'm fine with using GET for notifications for it.
I'm also okay with adding new ID, up to you.


>
>Is it possible to add this to the Netlink YAML spec? off the top of 
>my head I think it's a "notification":
>
>    -
>      name: $name
>      doc: $doc
>      notify: eswitch-get
>

