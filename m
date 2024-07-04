Return-Path: <netdev+bounces-109301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8848A927C88
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 19:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 281C2B23333
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 17:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4B24085D;
	Thu,  4 Jul 2024 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRlc9Mld"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551986DD0D;
	Thu,  4 Jul 2024 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720115519; cv=none; b=V/0c2hxW+Lxxq6NkLGaN7/XjfQeJgHviRxfmySNCaaNniEQZlMuEfpyOc/Pfz+3sxVsdXtuSrjAo2WZK9bGMXnQhigIRbfEaKas2NJkyLVqTBk+NVlIpBa+r+u1tbJxrCCKLqFGKb7gOhcyt/tDfMJz6rIKckAV+nCbgInBWfAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720115519; c=relaxed/simple;
	bh=q9ZGDkNDaH5zEMSc1zQxlXWMpC2ttmRI/VlhJHn6Lgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhcbflLFMcPbVwGIwVU4xKT77l79Z2FBsVVG8fZMheFHt0+cGG4Nwx5GqcTzUGuB1NnZCVDiYTjTm9+Oe4mSYDhLYJ9PkCGy7lOc5yX3tQCUz7glnrab2pRmbE2J1HF34rRdt46gbJzdCTkm0uLqEB/yeJZEezYetIQl/Tb2Yxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRlc9Mld; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6515b824117so7822377b3.3;
        Thu, 04 Jul 2024 10:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720115517; x=1720720317; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q9ZGDkNDaH5zEMSc1zQxlXWMpC2ttmRI/VlhJHn6Lgk=;
        b=MRlc9Mldh8vmL0Bdzt1IiDcOD3Uq9h5Yt3l4495CwETYrUmrGl5jIuR1R4SPXl3ZpU
         giYaHomVmHmROb8D/cItVLR+uh+le8RiCMBh5GDX9Vkwe7JVU86L3sC7mF7hm0LHBFMO
         AiE/lIKRdqHOC/YOv0jEsMnmUnuEGRJkhT9gIbt9+y9+0cwsljr69oLqTMkt/TjawlIl
         9iyiPbUQ3n7fkBWhto/I3ZkNwIQZBmuwhpKEY9F6/g8XoCGeVNYAiE/BxtyihTGqbahx
         iBUYDxubRECRCaQNZKuuF0G+k0vvjuKbTkOuD0IOp043vujK726s7BcD27MJHhf1UN7g
         6q5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720115517; x=1720720317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9ZGDkNDaH5zEMSc1zQxlXWMpC2ttmRI/VlhJHn6Lgk=;
        b=U/0dKU4UxO1/u8ziHGpV3UtRWpAJPeN1Wdli32kmK5rP2CK6rfe5JIEifsIFJAimmx
         w2oZX+NULeNWmEoBhQdz1uLiv68dbeYCflmTz6VSAP8cBWTZjAE7lvECRmTW+4dAotJ/
         BVdFjUir62Dam0gZ4SDymCBVLQdPThwZ4BrhwBXmMWAIlk3g1p9+A/7Zm2RpG/OCDENR
         pBkPWoaysjuJOJRZhSFEjj+xMfFB9jeRMuLUsOWi54+/W2RBE3UDdO/2spqcbdI09ZD1
         d6FgoqC6JGYMViMLA6f+bYF+vMxS45gMt0FEl9WtJOH+yyFFU9VpxwbexqRonkbMiTlS
         XXVg==
X-Forwarded-Encrypted: i=1; AJvYcCUXyiA/dv+TotHqgRp9NS8oG/eVH271lzglwtIIsI1JHFWiIsMO+ldY4Zmi54g6ayUakIy60LXAMWOHeD7alNIhMzoF+3Jc+/V7Ivp8bXE/c3WjBg3rHfiU1dXBI3BkTnG+OdI7
X-Gm-Message-State: AOJu0YztYzv+iVa9zk12oGzkSJVeSCC1Opbnjc3RpQmXSA+RCdj0+t2A
	MsZ4LowJe81tGThOJIiJSXAq8CJfFYFeoeykAOv+u5ZQVq3N3Pujw1lMmorUdg6GTR/MX33YY1k
	GH/l3g07Y4dp7eLWRTDCzRUdl3w==
X-Google-Smtp-Source: AGHT+IFIAR8Jj6Yu1jYElOsdEpuLchqpXnHbG4ciCJ1Ndo9m2ANXqdWA7wPkeW8bfWX8rdNtiNiUj8+kRAEvcRzjLr4=
X-Received: by 2002:a05:690c:4513:b0:646:53ce:b365 with SMTP id
 00721157ae682-652d8039562mr27222577b3.42.1720115517284; Thu, 04 Jul 2024
 10:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e3ece47323444631d6cb479f32af0dfd6d145be0.1720088047.git.daniel@makrotopia.org>
In-Reply-To: <e3ece47323444631d6cb479f32af0dfd6d145be0.1720088047.git.daniel@makrotopia.org>
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Thu, 4 Jul 2024 18:51:46 +0100
Message-ID: <CALjTZvYxwte8yO57V_rxZdh-=J2cvf38xHx-7NcQzE6nVG+Y-w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ethernet: mtk_eth_soc: implement
 .{get,set}_pauseparam ethtool ops
To: Daniel Golle <daniel@makrotopia.org>
Cc: John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
	Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi, Daniel,


On Thu, 4 Jul 2024 at 11:14, Daniel Golle <daniel@makrotopia.org> wrote:
>
> Implement operations to get and set flow-control link parameters.
> Both is done by simply calling phylink_ethtool_{get,set}_pauseparam().
> Fix whitespace in mtk_ethtool_ops while at it.

[patch snipped]

Working flawlessly on my Redmi AC2100. This is thus

Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>


Thanks,

Rui

