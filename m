Return-Path: <netdev+bounces-128878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254D997C44F
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 08:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 547EC1C21873
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 06:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B86718C354;
	Thu, 19 Sep 2024 06:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnjGgpZ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D564218C34F;
	Thu, 19 Sep 2024 06:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726727363; cv=none; b=J7PTWYbCRRh80ONHQxYFj7Afo6UpImr+xe1CgeIx75Kf+dn6/Ot4gymNtV6SNz1pG6v5bqdzicBQ/sbld665+VPfJz2jbJdQ/ebLKuvcG+9F3yWoKQPA/PZiDyvn0QS0LlhIrEsEV14ctPxIc8jU63RIiG/VUwnErWvxNeHj7sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726727363; c=relaxed/simple;
	bh=938CjvFom+LejqKZBOgywlJ1AHCtc7uRhymgS7xcK20=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kR4CDLFfK0Wp9EGXJMgJQRXF/xFvnH2opppV9R2/b81q70rgTfrHIiG9jw7Gz0bji4sh3SCvyRD4cHv1Gx7JVDnrxFT1kYEOCQg9F/rK7wo6CHUvgLhcG/LzZFWqMZ/mg39q+gm2Ps9iDEe70rK7RuZI5QMUTtTWRVTGbrGp4SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnjGgpZ3; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so360584a12.3;
        Wed, 18 Sep 2024 23:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726727361; x=1727332161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C63+s7ScHmJVMBST1esdfNvtDUvk9bPr8WqCmBeXBJI=;
        b=dnjGgpZ3b5z5CCmO19+SILTqNtU3W6S/Alotvbr6nl32CSo4kvlzZoXcW3wQZr6yAg
         Se2/Q+027UWd0mDNoRilsR2ghOM9SnkY92FlxvEZN74M6Y2AtuwdGK2byPH8ENERbouG
         vOZN5RC1mt+N+ga/AqrkwaSJcNUYypnJBJ6vZS15fgS4Ck37dsHVNdQiz0HEzUlX068a
         Lmi1Tnz9ksb5UzXjAkZbPgc0ee0QMBPW63j4HKGKwArBsBnp4uRUtXjzaYeztsvVG/RQ
         WLzIjuhFPFaKt/98nZ9PotP5X46J/9d690OVzZEnMQrRgE8nBjwGOOZk+dsdJ0jR3Wys
         12zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726727361; x=1727332161;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C63+s7ScHmJVMBST1esdfNvtDUvk9bPr8WqCmBeXBJI=;
        b=Ba0Ga7jmdpYjwhFk2glv18xoE6DRseEOr278AzuH9NnMSo/pozSbuJDDpe82yAaFWv
         xtQzCCappFNpK4VuumSM4wBjFsUD7lMYFKk9e6iuIjG1vEOslie/LgFA22R45GQxxYId
         L6dB5DTzkAppgDTb8J49/+pJyMGqelX/NqDwlJ6lsZ2ivW/Z9XSQ0EAhCCkhi1jwsoHF
         gBD44eTY+RGPPTCyVKgrUTNz5Hl8rlHd5JxCT2Dge+pd+1eH/WSTiVo1eVcl/YRXisol
         LAH6qsSEZQVhEh/ESGWizhgQJDyv3yW/jsT+8IVqRfJyf48gpBdfo80zJLQPzFfY4dru
         4y+w==
X-Gm-Message-State: AOJu0YzYDzR9QocXwbj3yHyT5i2V6fs3gZrhp98MT/khJDNHFqIh4JpG
	m3EtEt+GL8qA5P9zW6gYC1XPZiKkJ+qjov494ddP5Vwc8na+kDrPUtmyT7Fd
X-Google-Smtp-Source: AGHT+IEhK/q3G4Y6ya8di+Tc98O0c30tpMfD8ruEfFW3KLyhK6WZpg/2rz6fjtMY3fsmWZBfnys8LQ==
X-Received: by 2002:a05:6a20:30c4:b0:1cf:9a86:56ac with SMTP id adf61e73a8af0-1cf9a8657b2mr679660637.17.1726727360854;
        Wed, 18 Sep 2024 23:29:20 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7b1a2sm7638240b3a.132.2024.09.18.23.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 23:29:20 -0700 (PDT)
Date: Thu, 19 Sep 2024 06:29:07 +0000 (UTC)
Message-Id: <20240919.062907.1995257915073920166.fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 lkp@intel.com
Subject: Re: [PATCH net] net: phy: qt2025: Fix warning: unused import
 DeviceId
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20240919043707.206400-1-fujita.tomonori@gmail.com>
References: <20240919043707.206400-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 19 Sep 2024 04:37:07 +0000
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> Fix the following warning when the driver is compiled as built-in:
> 
>>> warning: unused import: `DeviceId`
>    --> drivers/net/phy/qt2025.rs:18:5
>    |
>    18 |     DeviceId, Driver,
>    |     ^^^^^^^^
>    |
>    = note: `#[warn(unused_imports)]` on by default
> 
> device_table in module_phy_driver macro is defined only when the
> driver is built as module. Use an absolute module path in the macro
> instead of importing `DeviceId`.

Oops, the last sentence isn't correct. It should've been something like:

Use phy::DeviceId in the macro instead of importing `DeviceId` since
`phy` is always used.

