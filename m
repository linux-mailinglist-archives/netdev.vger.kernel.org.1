Return-Path: <netdev+bounces-122662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CDC9621AB
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 09:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26CE01F211B4
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 07:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F040D15A85A;
	Wed, 28 Aug 2024 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZUQtQdR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF0B15957E;
	Wed, 28 Aug 2024 07:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831321; cv=none; b=BeYeXE9hc5mCA+lJT2ux63ACAPYBtvWrCmkvOOhRDWCKd0w5VngBQh3k4WKIQN6WL3AoM6cS3jrJksWxu3FoOI05Ah5xj5f+8SBcwUlb9U9o24zDVPuCTLWqOBdg4/2jXc8bMNszEgwxP1MBmHXisFOcLcGpj7O7+Em0joCZtFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831321; c=relaxed/simple;
	bh=cvwBg+vc7Z5xuhOLUoW6MzYNlOuDcEp0GnvSg+atvNU=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=V8JGxBCJMCe/B4lbT47/ObxZpktDdBhG5DfU8OBpHrFNnunH+FaH8E3wiXY2vzz0C8Rt999Q3Ue6IS346kvYIG1dqbMYjw43gmXBZUMvfv/KzvtVXF6QHtN1SafF+0aPM7R4tEo7UCjgU2cBWKv6G3vNX28HlcPYvUBurGh4EME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZUQtQdR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2020ac89cabso59345325ad.1;
        Wed, 28 Aug 2024 00:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724831320; x=1725436120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QdM11Hzj21jX8WIQIsqHNUec34LU9DCiYb1eu6IcWC4=;
        b=EZUQtQdRYYgUppKT2kGuvd2BbrmWdSUcTHHvIgCPEE5OnXOZn/7pBvwqv3muxgG0cg
         JiF1pKMEfNsMiBM59FGtViJXz9YpdaUzVMTQyIS+kWBwrUoG6rPHq8o/jyP4PeytjhvR
         Wf20R4bu43Tz2t7w3bElEXrScaX3OMV0SSc3g0QfmMG+bTDnnLtU41u63FIMl3RkzB6W
         6T51wkCAdxMqiJH8IdUNjm2Nx2ekRzN6kj7DJGdnriz6CCXXWsKS0YksXHMaVlxuyplK
         f13HjAtlcjyQPH3/MC7BwoOWXKpaikkgPeLUW/k7PLUSbCn3NVv4a8/Ok5NeJU6ou+Ab
         VXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724831320; x=1725436120;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QdM11Hzj21jX8WIQIsqHNUec34LU9DCiYb1eu6IcWC4=;
        b=Jtp8ZNIFY4sdGP6ShEjUX7RYxZFxwO4GPyYgSzt8cy1yoDkGx0eIcyE8ydywiDMOUy
         JYdMttm5BkfZfuHN2Q9dXv4vSjR0ziGxb2uJxTMxc3N5srSKB8jqUuxM410JEjYx2Vx9
         OkpZXmK/jtORoDUK790F+oNPHHaFlIEmrmEc108f2ZUNEvntXni6Jw4ZJTqutf94MEbT
         X9EXOzUPoZI2bZPy4WpsA/Kcyt/ui5SEDygm+9JFAjuf61TY9fKg0zT7ulGE/lzhTZ/S
         UmAZ/oiTg6QEaoSeRzgi4i3+xy54Fw0sKSAdrjnEWbn1g8XEVgRhBgX4ox7nLG4PtZ8E
         3Ezg==
X-Forwarded-Encrypted: i=1; AJvYcCX4DxzA22pR/0d/xPvi4GeoZrfNU8sNDjn4VQ6wCn86yoMvQqQ33yoOmuzyuusqqzdEyqiiFF9r7F6jZRGkYqw=@vger.kernel.org, AJvYcCXVYsetAuuQ8nz/kO5e0fgbqzANCw5lOTpWbgWZOjV+DsDSp7mvsjJY0ctqNOBrW/DoejTgQDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSZs5cJpRTUBFpFHYgsBV4a1WMvdoQa4OdHpd7fdWOZFPYSkne
	4PT8qLljv8SJ/VzDwRVfHMS2pjRTTJeVa7bBk7duZ+c+/IWVC+6O
X-Google-Smtp-Source: AGHT+IGE6ra6l8EkQgKy7Qba7L/AqIhjet4fFtoGT2PwCnjMMXFoF5b/Y6UyyjGCWeBcEGWTz2DMSg==
X-Received: by 2002:a17:902:e807:b0:1fd:d807:b29e with SMTP id d9443c01a7336-2039e4ca6e6mr172972615ad.35.1724831319563;
        Wed, 28 Aug 2024 00:48:39 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203859f00fcsm94267385ad.247.2024.08.28.00.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 00:48:38 -0700 (PDT)
Date: Wed, 28 Aug 2024 07:48:35 +0000 (UTC)
Message-Id: <20240828.074835.1208741310226632116.fujita.tomonori@gmail.com>
To: kuba@kernel.org
Cc: tmgross@umich.edu, fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
 aliceryhl@google.com
Subject: Re: [PATCH net-next v7 4/6] rust: net::phy unified read/write API
 for C22 and C45 registers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20240827141414.5df849d5@kernel.org>
References: <20240824020617.113828-5-fujita.tomonori@gmail.com>
	<CALNs47uSeGR_Z_Bor4yKbd848XdohHMam47zwBct39nEmKFb7g@mail.gmail.com>
	<20240827141414.5df849d5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 14:14:14 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Sat, 24 Aug 2024 00:44:50 -0500 Trevor Gross wrote:
>> Small suggestion: I think these could all be `#[derive(Clone, Copy,
>> Debug)]` so they are easy to `pr_info!(...)`. C45 doesn't have any
>> derives.
>> 
>> This could probably be done when it is picked up if there isn't another version.
> 
> Please respin, it's not too much work. It's really rare that'd edit
> people's code when applying in networking. The commit message yes
> but code very rarely.

Sure, I've just send v8.

