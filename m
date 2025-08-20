Return-Path: <netdev+bounces-215215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F80B2DADB
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 13:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E29C7B9967
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951F22E4251;
	Wed, 20 Aug 2025 11:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvoRCtrH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA712E2678;
	Wed, 20 Aug 2025 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689063; cv=none; b=mXjwF9mS8FIHXUcWcWS1YVcADTEaRpWvr1GYw2uXnLMMVHz6fts4gm82BxOYmL1H2EkkMJCUCu0hz+yMRnFB1jRM62JUKU8g3lV0cH/xlDENS5u2BqW/DMDyIbr0UEXDQ4QQPVgQcx3Xlgs4FR7m+sZVpClgwxX2x71CtPQ9ykI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689063; c=relaxed/simple;
	bh=DRnOG9sSRNpZEMljPWn3FWRRgBxmtq8FT5EKU3M9SMM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=JWdEhG+uy/8cLptOuSB46KK69M/Csjx+nZ1ILXZdCzFppwNp9bpzi+JFWxzOdJ98AizwD1gybHPWde/BGBxweyMPnUY3A4EGXflhjXBS0e5zMsjFY1azP7cRKwOBzQPR1yohEObnLYQIEczq7nokYGT+8NM5PT4laZA1BLnXpe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvoRCtrH; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b10993301fso64822651cf.0;
        Wed, 20 Aug 2025 04:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755689060; x=1756293860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=my7KO/pHjAjRdO4zqaz5rZYgcRd7sdUk2VHYMeevSWs=;
        b=HvoRCtrHDCNOcaUnZNr1k68YxizXFm7UvoEoNKWWiTKshKb1EIGsV+G4Z+eXvli09M
         Aq/O4biaHTzrvOWCtSUQ+n4QVzaW2RA8oc48/AD7eWFRF1EkcVMYNk3wwdfpQ/R/VQrB
         p0I9ajL8AYi15vL/oq/Z3iyTsDZz8NfL9c/Cc7iTq6vH1PmNV19jchNdAu6UHSso6jQ4
         8RiYrskiaBsMLBZ02yRWmqLt+Clfpzn47jdzVudVXfRT8xJZ1dPcsDjDqdscNoNkdJFR
         Ux79nmDTLi2KJIUTQlQGXAQBM4sm/CLd6eigEEZXASX/ndiS2AA4M93GoUjgMeYYKIVq
         tavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755689060; x=1756293860;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=my7KO/pHjAjRdO4zqaz5rZYgcRd7sdUk2VHYMeevSWs=;
        b=BXFbipdAbiPSlKuYDT6qdRE/2hE6QCiyjV0XTU3nq9TLAwCwjbAUJkrK+/ZqJPzMtv
         a8d2sQ+Jya9qLB8EWoy5T7uchDh1u0cA7tRq8ng3la9HbEVy2ohtm0rWXs136U6h3ycG
         DQrEfhUlqIr9QjauUXCxwJ1Hg6IzCsf6qXOk6r0LrkMdcCDpuKQOkVlucXALHnK7WjtQ
         /fMA6QgJj6Q4C4vsumayMpiPtGS+Dbbs2I7SfIGODBEwt0VMklZuXzV0onDBypRw8ns+
         JUVGeQj2pXe9hnRARiiuJbGZ8X+N2S2Xwson/bNC4RVu6QqE7bzivNnNhq3a8mSAf2XL
         v3ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVNLaQwLOv1VW/X8jdd3m4FVWoZp1lKjgFRc+GA6FI6xJA2fVegZfL+Ai4aw18ewp2qPWHzp19DNU5dHAM=@vger.kernel.org, AJvYcCXe36Dz/U0KIw16ZdJSuzvW2gBVdKeRz8YCV2UiCIuMrRmB7kuWtqdwpCbdZz0D6cAHeJBM9itO@vger.kernel.org
X-Gm-Message-State: AOJu0YwHhe6MH8hQpj3cTou0+OPnZW+AhbbQhBXnqYnN3/aRQTNx03p4
	cWJQwAdlwqUiBOXmO1HNzrWkAKkGSJWmFpiwJOG2CeIFqWwoKE+JAcoV
X-Gm-Gg: ASbGnctM317GWL6eSxJqhlwD/SQ6os7g6sb2o+FCyMvOfIQAYDKJZbPf3G7sPY/o5FI
	9zS+e0B/rM/s+QEPjb676eNLfnjVGEUmkH374vF5qqCdUFlWDBx2diK9uiSAaK2U3OxKDaScFRJ
	DrcN2n2WqmTqXhLkr32RFX1vact1UU8lKBJR60fcE9ZHQbJ0abfKUKH5VFTtOGANMVzFko1NN2b
	oxmoV42xA4kP0wfghH0zHhQJhLv6jL3vTrlW07ON/0rMLnjTpmMka4/HZSNzOxUhEP8JQfFaeTA
	8D2xWGtyJgjiVWLDdgGftT3MrxLe6GgwT9vd/wIdDBBEgpDd6/vQOo80HjkTqw3ppDEz8iAsxVj
	tMuRG/AstLxOjRqcLqe6AI4OLWng5N9ojaDjkoAEBhd8V/8C+xNGYRI7kc3IHZbwRpxv+7Q==
X-Google-Smtp-Source: AGHT+IH1jQlP3LwAJAY8u8ic9zg5N7e9jmnlFGaZDWewfLNcGR6i7bnVUy/wxD5RdRTX2i6qX6MK7Q==
X-Received: by 2002:a05:622a:4d07:b0:4b1:8f3:eb1e with SMTP id d75a77b69052e-4b291c4fb2bmr23991131cf.59.1755689059818;
        Wed, 20 Aug 2025 04:24:19 -0700 (PDT)
Received: from gmail.com (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b11dc18d88sm82924681cf.10.2025.08.20.04.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:24:19 -0700 (PDT)
Date: Wed, 20 Aug 2025 07:24:18 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 corbet@lwn.net, 
 shenjian15@huawei.com, 
 salil.mehta@huawei.com, 
 shaojijie@huawei.com, 
 andrew+netdev@lunn.ch, 
 saeedm@nvidia.com, 
 tariqt@nvidia.com, 
 mbloch@nvidia.com, 
 leon@kernel.org, 
 ecree.xilinx@gmail.com, 
 dsahern@kernel.org, 
 ncardwell@google.com, 
 kuniyu@google.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 ahmed.zaki@intel.com, 
 aleksander.lobakin@intel.com, 
 florian.fainelli@broadcom.com, 
 willemdebruijn.kernel@gmail.com, 
 linux-kernel@vger.kernel.org, 
 linux-net-drivers@amd.com, 
 Richard Gobert <richardbgobert@gmail.com>
Message-ID: <willemdebruijn.kernel.27e6f89480dab@gmail.com>
In-Reply-To: <20250819063223.5239-5-richardbgobert@gmail.com>
References: <20250819063223.5239-1-richardbgobert@gmail.com>
 <20250819063223.5239-5-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v2 4/5] net: gro: remove unnecessary df checks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Currently, packets with fixed IDs will be merged only if their
> don't-fragment bit is set. Merged packets are re-split into segments
> before being fragmented, so the result is the same as if the packets
> weren't merged to begin with.
> 
> Remove unnecessary don't-fragment checks.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

