Return-Path: <netdev+bounces-63758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDE882F428
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 19:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0D741C238D8
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 18:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9E91CD32;
	Tue, 16 Jan 2024 18:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYxPjFJ6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1381CA8C
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 18:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429415; cv=none; b=GHIy+/hgYLCVFxWgZuMwHfkRdavMyKTArR3BXyPRYavHCUTP2t6jAvfz/i1Uk8N9kMfAnRO0AEiwkjleUYBDbYmXFhTj4TpXh1lnEmFpMuLhpo7A6SEwP26GjVbBeS/FVqnSsxrPf4Vv9n4CMOMi71LQZ9HUPTSqSReAWXr71H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429415; c=relaxed/simple;
	bh=X3pYoRAFgAE0wsB6vNzzBNSBpdT7/LUTTEsdnzfxD0U=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=CTJpj7C+WvAiVfuxH5VxU14pYYLFzaKub8ZbVZPZB+XgRlXU2a1e5gHYAWRduN8ZFZsd/svHolnfVElu7CxiI1mr9aDxLkvnYi5N3jpqVVNS80ww+1WGDZz9iJkjbym/azL3b7dADNF7x9SKyvQAlXbrGjz7cLnVMaee1lfvk1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYxPjFJ6; arc=none smtp.client-ip=209.85.215.182
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cda3e35b26so3713788a12.1
        for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 10:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705429413; x=1706034213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wxO2mm1zelewrbCAsswGvpu2BIlCOXHw7k1DV0oLoqA=;
        b=VYxPjFJ6k1zrZ/Nj5XXTcSPSvGYit7DGFQtrILGcIutKXGnDUkO9IzcDYLW+5quIaq
         UwTHtoKxmkxKDXRkt+H3vGNZ4UPFqQZ1bspgBFWl2DCKrtRtpAAFzfniB3J5kuwvbMF3
         vQRJdNvqd56cJSWbnYm+xc5h+leNWI9vi9BVu1RIBxdVksTl04SNyKDCTPBEVuD9KdM+
         mFwdd+CoOwClDfvn3MfzQZ0OR7wxucVW0bVoYt6/q/cTtXvXGSxu/0I2ngxxUIM0OWK1
         /B3PrJaPZegMvo/qF5KjQ4OVZ4Ect95YkKEcCNPj7PVSyPrQ4cME8VM5zHqBVtov5b13
         blFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705429413; x=1706034213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxO2mm1zelewrbCAsswGvpu2BIlCOXHw7k1DV0oLoqA=;
        b=q+cxxnqtddUXQZ5wQFU2nEj+DEPLtIbxqoW4Zmyi2D14aLvHn6GpBmHJgxBJoTWuKV
         DeUE/LOBYfY/rSU+NdI5DeTUtM8fn8S8CXF2GOwi6UtL3pjQor+xsMNOvk9f06+Aa/rp
         7Jm1abYGytyJnJhZGun/wXBADb0is5WJu/twhm2lK9Aw9G/4BZyVN3WP/LmZe5KqsAg2
         zwEuPxhvlDqP4AxCsmLpqBVyUxaX1uDlF4zDvaADXRqwcXLs/SMa2y4+jc3o5AnrJVyn
         QyxJ/DjCM6Cel3iw3XZmdUzoPwZlMsqWeF2qoGkK5x8WQJjD26JsgR5Fm8iXeFx2Lx4T
         +5iQ==
X-Gm-Message-State: AOJu0Yx2kj/nROAr3fuvvTEftAhzmIB+F/rj0m2IJiXOWx7TEVnzDgmt
	U5zTX7j2F65K5qLR5rot5MY=
X-Google-Smtp-Source: AGHT+IHqhHgvhPiGVDVqtEuNzZfqh0AbQE5uFnqslbmcIznpuR2PFmT2dqxP5bZmO+kH1YoMh+dl7g==
X-Received: by 2002:a17:90a:dd84:b0:28b:a14:8172 with SMTP id l4-20020a17090add8400b0028b0a148172mr4424013pjv.19.1705429413460;
        Tue, 16 Jan 2024 10:23:33 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id dj6-20020a17090ad2c600b0028dd3ac24a6sm13308532pjb.9.2024.01.16.10.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 10:23:33 -0800 (PST)
Message-ID: <526bf36a-f0e6-4149-90c9-16f91ff039ce@gmail.com>
Date: Tue, 16 Jan 2024 10:23:30 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: DSA switch: VLAN tag not added on packets directed to a
 PVID,untagged switchport
Content-Language: en-US
To: Vladimir Oltean <olteanv@gmail.com>,
 Simon Waterer <simon.waterer@gmail.com>
Cc: Arun Ramadoss <arun.ramadoss@microchip.com>, Andrew Lunn
 <andrew@lunn.ch>, netdev@vger.kernel.org
References: <CABumfLzJmXDN_W-8Z=p9KyKUVi_HhS7o_poBkeKHS2BkAiyYpw@mail.gmail.com>
 <20240115181545.ixme3ao4z4gyn5qq@skbuf>
 <CABumfLwA5xMiag2+2Rjj6r12uqvnsTjrNGfp4HDp+pZ7vw-HLg@mail.gmail.com>
 <20240116131019.wmonfumccn25kig3@skbuf>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240116131019.wmonfumccn25kig3@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/16/24 05:10, Vladimir Oltean wrote:
> On Tue, Jan 16, 2024 at 05:32:57PM +1300, Simon Waterer wrote:
>> So a similar fix to ksz9477.c would be as follows?
>>
>> int ksz9477_port_vlan_del(struct ksz_device *dev, int port,
>> const struct switchdev_obj_port_vlan *vlan)
>> {
>> - bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
>> u32 vlan_table[3];
>> u16 pvid;
>>
>> ksz_pread16(dev, port, REG_PORT_DEFAULT_VID, &pvid);
>> pvid = pvid & 0xFFF;
>>
>> if (ksz9477_get_vlan_table(dev, vlan->vid, vlan_table)) {
>> dev_dbg(dev->dev, "Failed to get vlan table\n");
>> return -ETIMEDOUT;
>> }
>>
>> vlan_table[2] &= ~BIT(port);
>>
>> if (pvid == vlan->vid)
>> pvid = 1;
>>
>> - if (untagged)
>> - vlan_table[1] &= ~BIT(port);
>> -
>> if (ksz9477_set_vlan_table(dev, vlan->vid, vlan_table)) {
>> dev_dbg(dev->dev, "Failed to set vlan table\n");
>> return -ETIMEDOUT;
>> }
>>
>> ksz_pwrite16(dev, port, REG_PORT_DEFAULT_VID, pvid);
>>
>> return 0;
>> }
>>
>> I've applied this change to my version of the driver and will test to
>> see if any issues result.
> 
> Something like this, yes. It is clearer ("do nothing simpler"), and
> should not result in any behavior change.
> 
> int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid)
> {
> 	struct switchdev_obj_port_vlan v = {
> 		.obj.orig_dev = dev,
> 		.obj.id = SWITCHDEV_OBJ_ID_PORT_VLAN,
> 		.vid = vid,
> 		/* .flags implicitly zero */
> 	};
> 
> 	return switchdev_port_obj_del(dev, &v.obj);
> }
> 
> If you take care of the ksz driver, I can take care of lantiq_gswip,
> b53 and dsa_loop once net-next reopens, which also have this kind of
> bogus logic.

Since the proposed changes were not in an unified diff format, it was 
not clear to me what was being proposed, but what you are suggesting is 
that the following should be applied to b53?

diff --git a/drivers/net/dsa/b53/b53_common.c 
b/drivers/net/dsa/b53/b53_common.c
index 0d628b35fd5c..354dcfd23da8 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1556,9 +1556,6 @@ int b53_vlan_del(struct dsa_switch *ds, int port,
         if (pvid == vlan->vid)
                 pvid = b53_default_pvid(dev);

-       if (untagged && !b53_vlan_port_needs_forced_tagged(ds, port))
-               vl->untag &= ~(BIT(port));
-
         b53_set_vlan_entry(dev, vlan->vid, vl);
         b53_fast_age_vlan(dev, vlan->vid);


or did I completely miss what was being changed?
-- 
Florian


