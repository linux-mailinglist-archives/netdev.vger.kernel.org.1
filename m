Return-Path: <netdev+bounces-167674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8937DA3BB0D
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 11:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B85C3A2C24
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 09:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655FC1CAA95;
	Wed, 19 Feb 2025 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="2OP4d6V1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A561C4609
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739958973; cv=none; b=Zapp0EBS7QT4dboWSvHB1om9XaU4lmQPjrgIxkD0ayBy4cDM9FMIxziKoPeFTyUHNBvGHFH655F0a9VAOOiIOJ8xBhBx5ODf5bQvy7Xy1jM+mi9kKBNsmiBg3UKgLgSVVUOHE/rkdzgkHnl9PPDbLXYKm7BNq8H+krgO+OGWr2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739958973; c=relaxed/simple;
	bh=LKgAxsay8bSg/VTNpFJQhXaSdzXIXN8U4WjzbaCepqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ckpnHafkoDA//7USKDtw3LkqigD2BOhQD0V/fm5BP5mwC3bFHoTqBw+yPHiOqcFP75MyRR3XlAva9zEDZk7flVY1u+FGqQJhccVR8pmJ+sApAF5bNLCk47z+5fBllvYg3dwzkYMiasymbYbPa+VofrEf7wioOJ+I4DQhvDHTxOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=2OP4d6V1; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dedae49c63so2310744a12.0
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 01:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1739958970; x=1740563770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tbjx13fpZqk5rVRWYsQhCe7EaOHdJ4Fhs12YW16XcxI=;
        b=2OP4d6V14S63LGqwTFfp5cKGCFnd4ZUaSupk5snZYKj7yetc2eMbV6QlTIzwYqCoTl
         HDnwqDwCZ34NnZymjslJ1y8Z10qI1HSB8hrtRCqOi7iJnK/k84f+V8m5IRIc6PxfOXNg
         BNQOHmmaYyvKEKBAMqlndD0vv/YzL3gVBxaqyk+LU+Ad4XTXnvzmDyXXDZ3RghhgzSjt
         1P2R0f4y96ZbCwSBIh4sLP4eIriE6Wduj7jA2RI6YM1QR7xX2mmRPuBfRkTBm5bqtWj1
         cRtGSCuXZNqMZocSrdywT33RBVOkGqWFtq0OIY39zNdY0iKGxSZs5qiyTbIzrICQc3xd
         6L5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739958970; x=1740563770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tbjx13fpZqk5rVRWYsQhCe7EaOHdJ4Fhs12YW16XcxI=;
        b=Bb49xKJ0MHLOAj/7LihitGaDlxZO5twACL3O1MSiFPXO+uP69BVIdV3GJ9bZsn7QnR
         Y8QakcZLNcgUrStL813lE+Ms9mpad11Mkiuc3dKiLfodZQULx+/4u8i1+co622eJewmA
         rXwGCogK11NTrNNToFCIue2DJC5OCqleckywIzl6sQuvhVStbK+dwQ4F2HismfMOWRuz
         yFws6xIyt7Ac27GvRjwyTXQ/YyxU0wfpa8yqjzPoKI2qxNHMh6YKQ60183JC9ld3boAq
         3IDJzoY9agc1r6T1PjOoCAvBxhSu45Nx0ZyTx8IeRMJCdagClD6PNJjULlfTlbJ1gSuC
         pAtw==
X-Forwarded-Encrypted: i=1; AJvYcCUcL/SvG2Ean0xVhFsgbzIQkHX2oKqif71WEGFXoXENvLhnb79/l6xs5JdmHfNYrVj6fzsZKpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrjTf/sQzBz3HckNnYcVUdwFo9CNQt8MmKc0C69fWIYSQfOAmE
	Z/HfVDRH4hD8zvob52NAIGzsKne1OnBfSemV574DKUBaLeZ7gTiwlWnQFHLIbn4=
X-Gm-Gg: ASbGncsfpA8k5QuN0x/aaGajFAWs2WAR6klAOU8zz1kzLVAWuAqZFNGVyGY160vJcD4
	uZ8G8sKYLAL4qv3lw8uS9KoLaEJKgSk9VGo8hLdkTd+NjMhbBG61JXCs3i29pAGQ/UiLkQ+yPR+
	G7JLVUVAdR2crPfyFTX4VX1NDdjvgxhUD9MykUXqIXeiJL5R9hwZ+9yR/k4Li04uuFsD07dHwDR
	p3KlrBBpG9/lhheJxTfopYsnHieyg56/JjBx20Aib8gkCp/YSy52r9VOl2+OE+ckcN2A+xG3tvx
	J6AYhcBJMFReXNVjIFcBVOY9854IBEVz8O/40GUz59TdtOs=
X-Google-Smtp-Source: AGHT+IEqcWHiSuhGCtcap6Glaf42RzGtbM5j9x/510+7Fk31qW+urFZIR8KKaOrjoZNVBhEi81loAQ==
X-Received: by 2002:a17:907:3d8e:b0:ab7:462f:647f with SMTP id a640c23a62f3a-abb70b35f1amr1786423766b.25.1739958969313;
        Wed, 19 Feb 2025 01:56:09 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9ec913d5sm524109766b.170.2025.02.19.01.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 01:56:08 -0800 (PST)
Message-ID: <25fbccf1-38e9-455a-b114-da723041e413@blackwall.org>
Date: Wed, 19 Feb 2025 11:56:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bridge question] Issue with removing MDB entry after enabling
 VLAN filtering
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>
References: <Z7WnyC2eSFeb8CA_@fedora>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <Z7WnyC2eSFeb8CA_@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/19/25 11:43, Hangbin Liu wrote:
> Hi everyone,
> 
> Our QE team reported that after adding an MDB entry, enabling VLAN filtering,
> and then removing the MDB entry, the removal fails. e.g.
> 
> + ip link add dev br0 type bridge
> + ip link add dev vethin type veth peer name vethout
> + ip link add dev vethin1 type veth peer name vethout1
> + ip link set vethout up && ip link set vethout1 up && ip link set vethin up  && ip link set vethin1 up && ip link set br0 up
> + ip link set vethout master br0
> + ip link set vethout1 master br0
> + echo 1 > /sys/class/net/br0/bridge/multicast_snooping
> + echo 1 > /sys/class/net/br0/bridge/multicast_querier
> + bridge mdb add dev br0 port vethout1 grp 225.1.1.10 src 192.168.2.1
> + echo 1 > /sys/class/net/br0/bridge/vlan_filtering
> + bridge mdb del dev br0 port vethout1 grp  225.1.1.10  src 192.168.2.1
> RTNETLINK answers: Invalid argument
> 
> From reviewing the code in br_mdb_del(), I noticed that it sets the VLAN tag
> if VLAN filtering is enabled and the VLAN is not specified.
> 
> I'm not sure if the QE’s operation is valid under these circumstances.
> Do we need to disable VLAN filtering before removing the MDB entry if
> it was added without VLAN filtering?
> 
> Thanks
> Hangbin

Hi,
It seems you did not specify a vlan when trying to delete the entry after enabling vlan filtering
so the bridge code tries to delete it from all vlans on the port and some of them don't have
that mdb entry so you get the -EINVAL, but it should delete it from any vlans that have
the entry.

In this case since the entry was added before vlan filtering was enabled it won't have any
vlan set making it unreachable for a delete after filtering was enabled. It is a corner case
for sure and TBH I don't see any value in adding more logic to resolve it (it would require
some special way to signal the kernel that we want to delete an entry that doesn't have a
vlan after filtering was enabled), instead you can just disable vlan filtering and
delete the entry. So IMO it is just wrong config and not worth the extra complexity to be
able to delete such entries.

Thanks,
 Nik


