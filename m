Return-Path: <netdev+bounces-132509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56395991F8D
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 18:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55A37B2105C
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 16:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0FB189911;
	Sun,  6 Oct 2024 16:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dx/Y+rz2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0962AE6A;
	Sun,  6 Oct 2024 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728231050; cv=none; b=uta2jXldFh09Vth3vZs65ZM+UrOZk50MaxMkhOcLvD56KgVDQctYDhG63p8rgxcnLvjLwU/tWugxZm+lUqn9N7n/ZnUaiCoyljSWIfu6Fygi6NIIJHAON1eN9n5SLSRmRsLAk+q/gDXp7sdi+Qii3WrDBC30fkSZWfYeRNzBJ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728231050; c=relaxed/simple;
	bh=0Lua2qnPMgdcpPUR92uaBimqJ+3W98KBi+ZAZWBMLVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVJc8xkWZtKrKR8ARtGcm0gzsyxXIOz3HehYxCEqyJRkCeH1neeWKPy6bdx1DzbSgIq60nvrXjzalyGkieTFTnJw99Ao15sUepGj5ekqzbg7WFXIdf7U9srKcrXdEhg1KI8/TKrXRyos/3dG5JRZVx8JSOR90kEe1B2yw54dbxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dx/Y+rz2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b90ab6c19so39653065ad.0;
        Sun, 06 Oct 2024 09:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728231048; x=1728835848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tathN0BJtfsZc027P+vHY4yGiJz9Pk6Zz2tijUSDzbI=;
        b=Dx/Y+rz2+xvGdK3uhXR1+CdBbGPoioW8KQekptLsKTdOKpkXH3BtcmXdEwqHeTh7nb
         KOMrKYVgKzi/YXgYB0pIqu+De2tBDrWMr8aTYRMHQlFgVrOLPfvcRUxY64CEuUXNqd10
         i5zeVWip5dL6x94brb+cDIPooeHobq7rravLmep18Iu5zYUClSB1cQ1RLeveI7DN0aGo
         wmZnsYsUIoDRTgHJ2J8Bg7nq1otxvamgTr7frjV7UKcw9Myf1R4q0aTX3A4D7TLDDTf3
         3h6nOSxq9x3i14L3SN/krgRK+IHpmjdwsQs1IFpbHpmkUN5ePD36oeJJUyRvOxgQ3RjA
         oZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728231048; x=1728835848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tathN0BJtfsZc027P+vHY4yGiJz9Pk6Zz2tijUSDzbI=;
        b=dU6tnPGpg19ldFJddyB7S8fk3C077gB6Wz3J3/kR/lN2sdlTfGmlXYtE6ejyv3X7p9
         0HPTpQ04Q0x47muTYqnR2e0zi/BGZcmeJvdwHmZ/f0BZ07pOI77Iok+qyvktxUopBlCD
         lweTURC0zLoupNs4Lod5rMl7dwTe4Tpr77l4AKrbrCNPClkb72oeWEG7CXzrT+lz/aId
         OY50oao3LW+u3YtAZBRwiBSNdQ/G0DvW6hsHfgwtTXR+7gldOAqddIifhqjHabZorJbc
         kpuYZIsJLhC7ciH/QrYKOHosV6Ujf1/uTKsLEozJ3jzGnjs5U0PpE274luM//YerljHE
         swTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGeZqMzCIl46MP9lkW1Er8qxU2yjCi85OCdB6ZzjsXrpoaWt0TGGA86AfNZnf1znUCn2NrMyAk@vger.kernel.org, AJvYcCXYzs76jfdZk7qqYUS26GfMMSAGCf1I1oIVQlOBajFcaapKePC9LFw1DRkN2nbksO90j0OzTJa2u4MkadA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeCw2w+xEsM99O5xnffoeMs94gC6LDIzJaFZimd9XjGLJLaGbE
	G+H+UUu4pnJgnuaGfNuCZ8xUtDVzyP8gqK4ix/GYkAw8HDAE236DSyOhy9BP
X-Google-Smtp-Source: AGHT+IFS/b0y3EXdLGDgKb9RA1l3mm5swfaRndRWIuPaUok01FlHDXONE33b+lgzzdvP3CO0yK762Q==
X-Received: by 2002:a17:903:22cd:b0:20b:aed1:bf8f with SMTP id d9443c01a7336-20bfe298189mr140087545ad.42.1728231048096;
        Sun, 06 Oct 2024 09:10:48 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20c138cec10sm26689155ad.65.2024.10.06.09.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 09:10:47 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: andrew@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	f.fainelli@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	olteanv@gmail.com,
	pabeni@redhat.com,
	pvmohammedanees2003@gmail.com
Subject: Re: [PATCH] net: dsa: Fix conditional handling of Wake-on-Lan configuration in dsa_user_set_wol
Date: Sun,  6 Oct 2024 21:40:32 +0530
Message-ID: <20241006161032.14393-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <0d151801-f27c-4f53-9fb1-ce459a861b82@lunn.ch>
References: <0d151801-f27c-4f53-9fb1-ce459a861b82@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Considering the insight you've provided, I've written the code below

static int dsa_user_set_wol(struct net_device *dev, struct ethtool_wolinfo *w)
{
	struct dsa_port *dp = dsa_user_to_port(dev);
	struct dsa_switch *ds = dp->ds;
	int ret;

	ret = phylink_ethtool_set_wol(dp->pl, w);

	if (ret != -EOPNOTSUPP)
		return ret;

	if (ds->ops->set_wol)
		ret = ds->ops->set_wol(ds, dp->index, w);
		if (ret != -EOPNOTSUPP)
			return ret;

	return -EOPNOTSUPP;
}

Does this approach address the issue, or do you think it would
be better to pass a struct that explicitly contains only the
options supported by each function (phylink_ethtool_set_wol()
and ds->ops->set_wol())? That way we don't have to check for
-EOPNOTSUPP as we are giving valid options to each function.

