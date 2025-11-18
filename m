Return-Path: <netdev+bounces-239624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 642BEC6A864
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 17:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1844F34BA3D
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 16:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25BD36A028;
	Tue, 18 Nov 2025 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="vS+EwqQi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AA530E0E3
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481977; cv=none; b=J26Owm8UiRLSWvdzDS977/fnNZZIDxIqf6l+iiPT6apUxe5NMCcIHq8Z6HiVUQ9osrgsKXFyooRvxF0naPIyuIiM3anUVTPs+q1UD74HM5ArF+xBN5FkTKhklFbT2O8FaH2l8nBaoqFRpns6vuTZc0ETzlFe5PW35z7rDUb14ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481977; c=relaxed/simple;
	bh=YjVD6DRq5MWkVF+x7gkwrFTaWIUQiwpICXuAEgT4BwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JO5JPgYMpaF+freDfz2z6S/dNWq3C/FDFbxCRQ2kfy9gM/Nkv3/3EUMV7KTNm3lrNf6lBOx0oWalFGFpSpb2ikIpIeg5IoLBtUd813bKyE5DSBNhVpvN3t5r4+KRq/emVvc/RT+4iNRGK9e6K8ZaUVzuBBXmax1oz9H5iFW/f3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=vS+EwqQi; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-297d4a56f97so62978335ad.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 08:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763481975; x=1764086775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjVD6DRq5MWkVF+x7gkwrFTaWIUQiwpICXuAEgT4BwQ=;
        b=vS+EwqQiN9IPEZNUo54CKwlv55msFpGNjE9nMQ43vPtDvALcG2CMXDFOAVgdo587eY
         60PM5VMxWeHvk0qZznTBftCgGcRKHc44R8jK4yu//ZhKNzrr6yHTpi4tf/YhavRJTjPS
         hogm7HKhA5XVCsxmL2lH3XOU6STTmSAOqcz48KDVq1MUfGfr7Eh6upJCPfZ3oRqXsHev
         LBcVjPciJj5DAaR90QIqb6vHWfjZIKjdx1eJ/PQ4evqsWddaKLnlFapY/nwLXt5vGiyC
         kH3AXaYhCiDtzaCfwtZVlbjmpqAGOmNh0Vk5jwlE2he4nAdS70zudA+TATeRP4aXVeKd
         ZhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763481975; x=1764086775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YjVD6DRq5MWkVF+x7gkwrFTaWIUQiwpICXuAEgT4BwQ=;
        b=HpHHp7iPF9oIv6eLuuP6l72Gp6TpY2YQ3RQnVWyeHijUBKYG1efijLKLE8aQFKfE5S
         AYfzAu1xxrCEZrEAk5pnKA3dlmQAtqUFQ0Hx6BkCK6a02wHEe1lN/1/FsOvafvoM4sa8
         viY0hSwDxfrrmqLKB8KlBuGDABpcEfSJEaexr1N89X+vEzhAU/u7vKMItQRJGH+DVW9G
         7eEUFCXVp7jIbGFosMDP5vvaPOLtq/hafL530C4kf5ZF0VX9KDdZSzABsr6pHixHJq1y
         xBnZHvUujTl7YjQd7LS3tfIovhtny6lQLn9zjuoK1UwgE9WHVBwPaZDMNw+327x/ttTn
         jtNA==
X-Gm-Message-State: AOJu0YwSEUw0EyQyG/vNa9TpoUK4Kg1NRlIEB0hCws61jggQ+aYo+PEo
	iDRQvfh02UXJmJrV9V9nkrwEWTAX4RHCSuKNvPob4jNKz0fYdB3iYa/tNK81Ftf03ANwck2uG62
	iuz2d
X-Gm-Gg: ASbGncvQSdnUKbpvpSowSdyMGAIdH1l/DUfxu61cKOHnyCowQJswbAR50h58hAQMHV2
	o/LAJ2koURZheJOGkbjojvKHOI/rRr0G4X04E1svrAqtqZNRNWc/2E+pNF0P4cQpMCQP0MYyYXK
	6eYJ2jtpsLRm8ofMjEL9ObLRhcMP4jnTbypXAqlyFw1ZdY+FOGADxy+z1BAf7we43wvn/iDFaJh
	9b6z2i1f8mT4qnTSkhI2kGFB4hD6zCJQXCAsCcqMOMk1ldPj4PRwtMgyIKDGQCJSzrGMoowAYEK
	MGBZvMtQ6qUL9RxMTpnX5qo0F+1mNUB3PjV/abBf7wX15vfkTnVPsOLp1hMCrS8NiQArkWm6Pgi
	x2yUUvbyIlnpiqWUKUFOwLKjgBZI9i/+fAi1PWIHtsl7etWQEzqowlBZCZB5RuLHrLxRM1hVTBc
	o2Wm3oIg87x38JquRS2OAgp0ziP26scU/ClOUpgYtaF9p6aKSM3cQc
X-Google-Smtp-Source: AGHT+IE3UJvEuiPrp4atDcWihCRYjOncxoqE8Tout+yHcvqekJ+luaRFDPNrAp9vKYb9soc2oHw+AQ==
X-Received: by 2002:a05:7022:6621:b0:119:e569:f27d with SMTP id a92af1059eb24-11b8f160a01mr5988669c88.38.1763481975232;
        Tue, 18 Nov 2025 08:06:15 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b060885eesm62535012c88.1.2025.11.18.08.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 08:06:15 -0800 (PST)
Date: Tue, 18 Nov 2025 08:06:11 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
Cc: <netdev@vger.kernel.org>, <andrey.bokhanko@huawei.com>,
 <edumazet@google.com>
Subject: Re: [PATCH v2 iproute2-next 1/1] Support l2macnat in ip util
Message-ID: <20251118080611.2e5bdec7@phoenix.local>
In-Reply-To: <20251118112347.2967577-1-skorodumov.dmitry@huawei.com>
References: <20251118112347.2967577-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Nov 2025 14:23:47 +0300
Dmitry Skorodumov <skorodumov.dmitry@huawei.com> wrote:

> Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>


Good start, but you need update ipvlan_print_opt as well.
The trigraph is getting long enough that it is time for a helper function.

Also need to update man page.

