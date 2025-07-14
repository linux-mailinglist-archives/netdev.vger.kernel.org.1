Return-Path: <netdev+bounces-206625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C097B03CB4
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 12:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04623AD3A6
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 10:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044BF23BF8F;
	Mon, 14 Jul 2025 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="N8UfufDt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C9B23D2B4
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752490545; cv=none; b=qlYFXcbf5K8nQEtw8qCc2TZbBPtFbInGW7QE0t6y4FiAUhA8c91vkNErl5Xj5uZaYm2yDcP9TJCFicsSa57eNo243S94zCLprmQOHvxxjRHfGg0RJXc0MWyX35bZ0o0LaGfvmzhgtRTWBj17djT2N5ers4k4ssyTz40iiwcyR58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752490545; c=relaxed/simple;
	bh=7cb9WFYUNWjjjQmPmDciRuxuAnrKRgQqbOvIuBlWNwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLCnKqtC9hTC6FMXO6mctMfZIfexXmhPXWrzmuqpIcJEO7PhQz29Iy/rIPhRn+9bvrn8+yWFUyRZJAOPTnFTTuR5T3InTPWdOWPcT0XxtzWJsZKA9XmMgKnUZ34b+upl1capotIaG6YKHNHKicuvuMBO9VGn3QhTPqE0+Qe2lYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=N8UfufDt; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a531fcaa05so2374461f8f.3
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 03:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1752490542; x=1753095342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NgF8yRc8donJJs1fRORS+/MubsokBXuPHpy3GY/uTu0=;
        b=N8UfufDtVlnkde/ma/tnfKjuJPaLFI7XKayFQDJXRQGCcFsyNruezpFjMyth301M2m
         idPuk8/CVuw0mHWY0AaBcBQ1QFzJKi4yRCZfviFLmx8VRgBMjk7jJahrFoqXHegPrMvh
         lhn1F8UsfRMQvhef8iazlXkpi9d8zPZVGZngOKDCCShwNZ/wnFiLJH/CNymlhEWtBgKa
         NNAdvdCiDzlJKDtuf6D/7k/6zlGM3LPTDoRDKlazfJXTCPL/YcOTTVCfsMdmtfS5ho0T
         7wuR97oFzvDbYu1FtlHfvZcadWqf05rQVz7ybShCygDHdtvQpooP4YyukNg4sa+L0Woj
         4t0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752490542; x=1753095342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgF8yRc8donJJs1fRORS+/MubsokBXuPHpy3GY/uTu0=;
        b=KS+DHZYVVatmaDhhUxE0pBc3+PNpkddqp4zWkdHIB1fCDR5yue5KrHp0HDlrFHLpJv
         c2ps9e31iJgnyiYMIaeoiev/rZRxJqhzpOXjuo1f3CllJ0sWCpepqg5KHqGsANxOIXEs
         BKFl4zHqho/l6kMm+p5/97x4OEFosL7I/hmyP7AU1OI+LzDtf3dpc17lCoIgMWnk1UPO
         rQKwBlUBzNzUXGi9JnN1nKCj/CT2PDGgWPe5BR76jBbCCWWIjt+zF8hOPmeF0JG8gfwv
         08dcPIp7ZjsR+YmlJSDT92b1m5zXG/+d39zfo4ilvbucN7pRwRZ0cjXykzFWCLawrY8v
         hOYg==
X-Gm-Message-State: AOJu0YwEommot2sdALry2AikK4+nHzEQLAdOScvuZY6Vf3Css5S2P/tO
	ufp+fWHwR6H5KHwl1tQncY00EgD1v5ylZdKM8E+lzSp4ic+BUzTzB/UULVcuqmMnNBk=
X-Gm-Gg: ASbGncsGknQ1g9AT92dyFAj5vGtT9/83D5Fez7QtioxT6z8THCoorAJ8MYMeNaEQtRd
	7wJ08CJUnIyCJ3AoaFsCuLT7Wh+HCEN0PLINiVWneeIN0a8/mJm0C1iC6lECilAn+TMEGDqzidC
	ERyQk4DQ93Q5jHgvn41Ja4WR3DU5gGtfBHCavfDIHDym1No0+XHaSAUs89WC8pknxeUevZTLkvu
	6+oSZM38VjP8t230DDSqAGy0xg3UXYYQnscARDJwYh7Rmk2GINNwhn7stDosE61ew0QaWDpu9ej
	Medlktfxh3klGHg89fQrnNnHpDvyRMH1tgNkP85TRCCBI04WbIS4CW67x79nAh8q1YkhuUovMtM
	SoOANxk7P30elLUggFWP8JNgJ
X-Google-Smtp-Source: AGHT+IH7P2KUJvmM+7c5vG77bksdjjHB64AZp52LKTxT0JM4aRbHuVqCtO6uw1MsCfy3fWTQ2E+Acw==
X-Received: by 2002:adf:b64a:0:b0:3a4:f6b7:8b07 with SMTP id ffacd0b85a97d-3b5f18f8742mr10077598f8f.48.1752490541798;
        Mon, 14 Jul 2025 03:55:41 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd4b32d8sm128834675e9.17.2025.07.14.03.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 03:55:41 -0700 (PDT)
Date: Mon, 14 Jul 2025 12:55:29 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Prathosh Satish <Prathosh.Satish@microchip.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net-next 0/5] dpll: zl3073x: Add misc features
Message-ID: <zel6pmz3ohww2em46yx6ofd63cvb2l3fjeaj2kpw3uxcgba7cs@cgrixeubgnfp>
References: <20250710153848.928531-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710153848.928531-1-ivecera@redhat.com>

Thu, Jul 10, 2025 at 05:38:43PM +0200, ivecera@redhat.com wrote:
>Add several new features missing in initial submission:
>
>* Embedded sync for both pin types
>* Phase offset reporting for connected input pin
>* Selectable phase offset monitoring (aka all inputs phase monitor)
>* Phase adjustments for both pin types
>* Fractional frequency offset reporting for input pins
>
>Everything was tested on Microchip EVB-LAN9668 EDS2 development board.
>
>Ivan Vecera (5):
>  dpll: zl3073x: Add support to get/set esync on pins
>  dpll: zl3073x: Add support to get phase offset on connected input pin
>  dpll: zl3073x: Implement phase offset monitor feature
>  dpll: zl3073x: Add support to adjust phase
>  dpll: zl3073x: Add support to get fractional frequency offset

dpll-side wise:
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

