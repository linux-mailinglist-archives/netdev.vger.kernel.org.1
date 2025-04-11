Return-Path: <netdev+bounces-181734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460C6A8652C
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79730444734
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B31C202F88;
	Fri, 11 Apr 2025 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyeBXdo3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19D51D9A5F
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744394526; cv=none; b=spNbUwBAj0ssd/byRPf3z/e4zUrqXeQZqk9HWMaF3n2a7mHd2qimYTvxHKXg7tnPzgQ9wsz132I/zW9uy+g0NfuVAzxgoqsYMwB65k/wciibQYfPMsC7Yc1a0tCneHXXX3EciAdJyrShpVA70KBHaUvL1ZQmDJu/iQQRt1BtMPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744394526; c=relaxed/simple;
	bh=wkdc7nWzIlq0aLwu5EsrSUIL/7dxJX2wLbfdEGxcS/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J74BbyAEzem0YIzUvYkvzPqW9h4iWfeCIiaudAfkNCKVlU7W0eds4HDKGc3nQz8Lemb+l3dUmxH7wczhE0EqzX8ruzfrN8+bCBTgtKQJ1uo6kqI6xhjquPzlL4mwlCE/F0uue9NmZBDv674u0zDKJ71XNMQMek89++mmLEaXjF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyeBXdo3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf861f936so3855265e9.3
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 11:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744394523; x=1744999323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cJAiEs8/nCs/qtLyePz7Uyrx6BSqGxHZ3zKjckWHgME=;
        b=JyeBXdo3kpP/N5Gdms0nSctumGjP1kyjyzp+3ikndcTGt9UkOE0pC6x2UGg4Jr21RY
         tuZCsm+HGrE/qQiM95I2AJeTUeV45xbYVVTAuUoV34z0iN0F05+d25g74dffwbLt8OAD
         J7b2fkQc5Vi4Ac1eSRBtDUz2LCrw8m+qWwu4knju4F8zp5ne6/vGvIQQ/nBpK7EtfxTj
         viNXPpu9gCXoMncJMgRuwM1jBGO6jNA4dcxz9NUMVHG0bLKh9/RbHEp3lR9sOusvYhjD
         5jiPXCq8ADwzvrb1ccvuFEaXpxQQxZXlMOcKHaEILpKkjcHsyYboSC/iymzC981aqm3F
         zriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744394523; x=1744999323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJAiEs8/nCs/qtLyePz7Uyrx6BSqGxHZ3zKjckWHgME=;
        b=q51AyQ0oBFgeR+h1uHSP2Qbs+TZh3me3I+7sr/aFa+XRB1VnAxg65FJwVn3OBjUQCv
         uK1KbjYzolOLXleNtcWr3MK4as7jxyfdz5CitArqhat98c305P4idfBY1qg33qQpFRTE
         eLxJ3OjTsCX7Udjf8Wy5cTFB+Xt1PgSYq3EUslsZU8/+tWf2npX/wimPVZX0oZq8FOhl
         BHmdO08qqWTP+2/J9G8S6mshoaMBbiPRqREe++Jj0DHAerwLXp2tSLXun3m2vm/6gKTT
         Ml0+4HS1VbjN2/pwOCQ56kQOIERzYteloWtOxNSBdhXPACun9lkRRjfnaErbD7XNgysj
         B/BQ==
X-Gm-Message-State: AOJu0YyoQbhAumuYnOGlG5THiU1PHUpVvEdoaSxdfyYA8Eq4uS13vx9K
	34QlJGmMx1DOhJft0wGsvKmFjTVCni7x1txUSdcfYAK911rPigZK
X-Gm-Gg: ASbGncuRw5f10K3e1aJyvkj0s/TxKmmECkIbevWhui1/JLqt16hXR41Jrzr0vmoMRV3
	gGGwCJbNQOxG6Pqz1yX9ovMLgKllHX+ETDPgl6ckcbjIsVJ/9J4Myv7ptDX+kmk/J2gEd5fv6vI
	v5HHfR+aSnhiHWjnib7gaagZ0/hv4X7B0jDdlpBl5n526RjS/Pmb2N4i2oh3cayWXD3Jx4TrTt7
	NSi4gqqSHLePdk3evzIWuEzcjs8Y8kyZQxSri0q5dlw/M4X58l+ZilDArLh8FPbIAekC2x1TOz9
	zz6S1YL47V7QXbgntHu1gJn2oYjJ
X-Google-Smtp-Source: AGHT+IGGrNO7JiyP1Na6sOYRkNEzOq/M3EyxftfDlHr0rtzgbBhRPnpHFwibDAouma9EDbhvCkNrhQ==
X-Received: by 2002:a05:6000:40cd:b0:38b:eb86:694c with SMTP id ffacd0b85a97d-39e9f3cc3d8mr1043654f8f.0.1744394522712;
        Fri, 11 Apr 2025 11:02:02 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae9640e3sm2761354f8f.12.2025.04.11.11.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 11:02:01 -0700 (PDT)
Date: Fri, 11 Apr 2025 21:01:59 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [BUG] unbinding mv88e6xxx device spews
Message-ID: <20250411180159.ukhejcmuqd3ypewl@skbuf>
References: <Z_lRkMlTJ1KQ0kVX@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="uutffo7jejzecxsu"
Content-Disposition: inline
In-Reply-To: <Z_lRkMlTJ1KQ0kVX@shell.armlinux.org.uk>


--uutffo7jejzecxsu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 11, 2025 at 06:29:52PM +0100, Russell King (Oracle) wrote:
> Hi,
> 
> Unbinding a mv88e6xxx device spews thusly:

Odd. I never saw this on the 6190 and 6390 I've been testing on, and I
think I know why. Could you please confirm that the attached patch fixes
the issue?

--uutffo7jejzecxsu
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-dsa-mv88e6xxx-avoid-unregistering-devlink-region.patch"

From f4f9aebc0a8f8424a9a59536368605afc30a55df Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Fri, 11 Apr 2025 20:55:39 +0300
Subject: [PATCH] net: dsa: mv88e6xxx: avoid unregistering devlink regions
 which were never registered

Russell King reports that a system with mv88e6xxx dereferences a NULL
pointer when unbinding this driver:
https://lore.kernel.org/netdev/Z_lRkMlTJ1KQ0kVX@shell.armlinux.org.uk/

The crash seems to be in devlink_region_destroy(), which is not NULL
tolerant but is given a NULL devlink global region pointer.

At least on some chips, some devlink regions are conditionally registered
since the blamed commit, see mv88e6xxx_setup_devlink_regions_global():

		if (cond && !cond(chip))
			continue;

These are MV88E6XXX_REGION_STU and MV88E6XXX_REGION_PVT. If the chip
does not have an STU or PVT, it should crash like this.

To fix the issue, avoid unregistering those regions which are NULL, i.e.
were skipped at mv88e6xxx_setup_devlink_regions_global() time.

Fixes: 836021a2d0e0 ("net: dsa: mv88e6xxx: Export cross-chip PVT as devlink region")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/mv88e6xxx/devlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/devlink.c b/drivers/net/dsa/mv88e6xxx/devlink.c
index 795c8df7b6a7..195460a0a0d4 100644
--- a/drivers/net/dsa/mv88e6xxx/devlink.c
+++ b/drivers/net/dsa/mv88e6xxx/devlink.c
@@ -736,7 +736,8 @@ void mv88e6xxx_teardown_devlink_regions_global(struct dsa_switch *ds)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(mv88e6xxx_regions); i++)
-		dsa_devlink_region_destroy(chip->regions[i]);
+		if (chip->regions[i])
+			dsa_devlink_region_destroy(chip->regions[i]);
 }
 
 void mv88e6xxx_teardown_devlink_regions_port(struct dsa_switch *ds, int port)
-- 
2.43.0


--uutffo7jejzecxsu--

