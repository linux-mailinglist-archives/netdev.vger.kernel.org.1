Return-Path: <netdev+bounces-228311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6266BC71E0
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 03:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A3A18992E3
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 01:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5172AD14;
	Thu,  9 Oct 2025 01:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6mmMfUQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF25DEEC3
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 01:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759973650; cv=none; b=bezHICre0nTdlm9lqoVOOZKbvH6kB8Cr2rfxrT2Af7KF4yZz2ArKHDxUUwgjqyo3HpLbqSNfixkdY+w1sqkfO8an5YjvmziWuA2iOHwyYXrVKhK+RWHH9fJlMJJ5pdm04c3YUKO6/4ZyytTukLRiSYjvczkaRmDlJ1y2lZXHtuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759973650; c=relaxed/simple;
	bh=nw31RWs7URGV6u7HVA/lhffYgc8Z2l0LldHw/8K7W30=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=b6slzUtDBqGCzISAyrZ3ZlKGOIwEhWJqIPxrbykn3M9YZLnXDCci5Bliqvcye10tOHO/idrtvWQIQcrNX8I3dwMiCPCNROcooVBKOuxjaphuAWQugWl9Y/jKKfDUJW3aDUn4kTPyYdTz68LtxrONZw+wRM3Ysbl+NPDmxb8VblU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6mmMfUQ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b555ab7fabaso362567a12.0
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 18:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759973647; x=1760578447; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nw31RWs7URGV6u7HVA/lhffYgc8Z2l0LldHw/8K7W30=;
        b=k6mmMfUQCYmBCQOQUYbJ+4V6Qztc1XXpN4q+32qML5/qD1yKRqGekS3FHWPX8DlAuW
         WEYOyycNPNkTUBKiU2iV5bYmBPurV56mTRrgu6HSiQFshFUEiRrHOrmm9oF6gEz0icE8
         kZ1bt/obkCYQWdWVGh7z0POGBs9JDuxNYoiALDe2d1k1m9/CKUkhegioKco21mhZB+Kk
         hlwuWc+RcBtA6O/ZIdziAkBNK70ei1D+keP/FK6gPJU7lCfjKafaKO4n8n2gQT8oKMZe
         u1DphW92re8JxmYmDkfyKoDhY11gzMsoJvAipYA4KDJ8uMYTQsJ+Cn8h8/FnTh7YPyPr
         voLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759973647; x=1760578447;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nw31RWs7URGV6u7HVA/lhffYgc8Z2l0LldHw/8K7W30=;
        b=CkxjBoj2KcK6DN8dK9IMarZJSmAOLsQTKCsBBwAOINPsI3MiMBgM7SLPi8joi4n4Di
         NbRc1W5pRibgJTyGIJOgo8GBWgfQhDBDCyJGjiedWLsm5zgsVPfFtHLhiT32Bt5LSWJi
         FtaPPeuXTMUvjAcyr0/IFWcJ//ED/AbhLSu/SICiaSgQc0W8LTKWKL/2ZT/PIB3PsQu0
         yTZin8JK+MYVOegDdnycjQ0abk742pxja7g64DQu2Ke9dhh9lryxL2RGZnh02jG88Na/
         pc79tGQNqmT/rc22Kg1SNl85+s8Ny+yGPfSPVG24pxU0Ut6CVtlFQKvl0MBgfY2EAsT2
         6gDQ==
X-Gm-Message-State: AOJu0YxInOmP912wfyS9ChdoWT9KcjH6zYep81H9PA8pzOu9VLIWdkQI
	4jctBMwUZELcbmjRW+97+BoBNF07Mtx7rt609CFbCRZ+d7F+82FORjJy66wgEbWMXQawfLVEsTG
	1FFTlhpGrEVyy97KrskbMNiQhC8zChViZXK6r
X-Gm-Gg: ASbGnct6FVI9casIC+ICJik4r8VVv2wBscttGG6t15psYvrRFqaEwwgUKLOQqP+f9Xh
	vcbJIBsLXXx0ufsi2skCCn8n5wr43HHvp7qvxMnttwWnXjAsW0GlrLWQTN19YSTZZ6EoZip4nI1
	leInHJL00ZsGs4njcZd4KEYFFB8ojF6jkS4VVD2sXGtrOnkyIMFie4dUFaSk0vcTr6e/JQyPPd2
	3/dPo7WhHQ7B/XZcxjoi9gmRn7P+j3UDfl6XDcODINnZ+61eJMbE6Cw2x7xN0JWstlNzAjTQeFa
X-Google-Smtp-Source: AGHT+IF+z2qwf8qIG3Q/H/3fg7jWB5tIT9BSkPTc+a4gYJNGHVHxenKiwpLtFAEIG159XR0RZnOz1GG88khEhShEdVo=
X-Received: by 2002:a17:903:8cc:b0:267:9c2f:4655 with SMTP id
 d9443c01a7336-290273ffcf6mr65517225ad.41.1759973646784; Wed, 08 Oct 2025
 18:34:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: SIMON BABY <simonkbaby@gmail.com>
Date: Wed, 8 Oct 2025 18:33:55 -0700
X-Gm-Features: AS18NWDNEleDNOpz5zAI1nRfCILBnqrtfSeLgBSzxIoPsvd3eqdMGo7VNV_Y3_I
Message-ID: <CAEFUPH0W2SJkBH72o3jxDsVzM5GEMGS0uRwwXC6LDtwz3yLe3g@mail.gmail.com>
Subject: query on marvel DSA driver and ACLs (Access Control lists)
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Team,

Can I know if the marvell DSA supports the Access control lists and
policy based QOS settings for marvel 88E6390 switches. Please advise.


Regards
Simon

