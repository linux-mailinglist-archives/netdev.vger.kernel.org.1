Return-Path: <netdev+bounces-140827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7346C9B8611
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 23:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2F61F2265E
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 22:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A321CC8AF;
	Thu, 31 Oct 2024 22:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7ZHq4LJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3A613F42F;
	Thu, 31 Oct 2024 22:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730413346; cv=none; b=XY434eoxEcSYmyQWUWum6ww6ervGJ67og7piAy1RgT2lCDFokaJrQxXdvaDVIe0FZ6cWC/GbXzVJTXEcmfAC79pA8/Ae63EWp6dupSgb8V4ms95fqZAxQ/XbHZeEnXTkItWItQEqni1c7VTczqjj28Qwhg445RMjlFADB0ZJx+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730413346; c=relaxed/simple;
	bh=5NUZ27c5/v49I/afclL9aehP0K7rXXCtyOV4RF/mVbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pik9F83xf6Az/0Ab71BNT3CzYHx1eAtkvIXnfW8qZovD950lmBlaEyGul3bZNqGO4qks4ZAXlNK6FfqH2GGG9QFjpcpU6TfF504cP1OKsO/xFaH4pdr1LN3xmQrNvyjEw+OPFL0mq8+rWZW+Mcq/RncN8l+SWz5eXNbnjOvXY9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7ZHq4LJ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d4dbb4a89so91221f8f.3;
        Thu, 31 Oct 2024 15:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730413339; x=1731018139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5NUZ27c5/v49I/afclL9aehP0K7rXXCtyOV4RF/mVbk=;
        b=G7ZHq4LJYDYXFdIDPfmzhN55CZ7gtQGcjBso/3APVATIuaFbHFvSQ2Nyd/Y0mEkSyQ
         s8CSerz0kP+U7SwBNKKxWRWwPR6kzZP3rybJteEIQImOq896DjDTOCHNWQozaLH2Fb3O
         n5HxsvyMMa+GZZh1IqQVPu3Ue1hq7O6oNVi5HWzF4erZ79HXA4+pS/AqfWu+rrUGuNjP
         75Q4TkdYFq0kjbH/xS5kOCk9nsBl8GryQgIXi9elO63iWsGn3rYTlRoUFobL4Dd0U3FG
         9qca7jYxGHulsXsHrWLmcbMvAg816qqCWy2Q7En+eQli6B0w8o2HjC37zWBw1OzVDET+
         y6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730413339; x=1731018139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NUZ27c5/v49I/afclL9aehP0K7rXXCtyOV4RF/mVbk=;
        b=ctT+Y7JJXOWK5KMTCuGXmFe3poJon7vdGyO1vREtzd9uxpOouCs9ezPNy2X/1DVZqH
         n96PdszZPRvlk6xpEZmA4k5VY3LYCiVj66aBGwMb9izyowC3Wpn3FGuUgTU41uomTpu1
         KU5nQTsDJ4VRncTLs9oAJ3AXHrpzTivuGHOxkBQermV1POzYb+OFPXz1YV8RwP8a0FKI
         adz6NVByzumE/j7Ms7xh7CJZaQTVs3nE2Emu4fXs63Vn9R2Znt38LF6kykOf/d+50Thh
         otuUkeRjVJW3n/KpE5Bek6NClHyKp1D4MmjVM1S+hdlF5D1bGEDi78YorzoEcxTZ1jjC
         OFQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0bUsRoocGel+rhBFA04cfT+RMnJ7rIV9bUlBnsPrlNxR322K1DA11Er+uZTwn8y/ugZPKuwPJiMYv3Po=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy21cxcnij+GbnH82lHN7fgZyzvksAPSulA34uOZaymyc7a4kUH
	kFSq+yfizxZP8AL2OsF7YA40RJyc/YJTA7LsIXhtm7if8qnz37Wx
X-Google-Smtp-Source: AGHT+IE44d0MFrUk0dibhuwJw2rpEKMUGjTKojmce33Tmr56c0u4vqt3XnD4DG8Tt8EgXf7Y97ce9A==
X-Received: by 2002:a05:6000:1549:b0:378:955f:d47d with SMTP id ffacd0b85a97d-380611fe5e7mr7618706f8f.11.1730413338686;
        Thu, 31 Oct 2024 15:22:18 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c1185b4bsm3249193f8f.112.2024.10.31.15.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:22:18 -0700 (PDT)
Date: Fri, 1 Nov 2024 00:22:15 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch,
	Andrew Morton <akpm@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Yosry Ahmed <yosryahmed@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] MAINTAINERS: Remove self from DSA entry
Message-ID: <20241031222215.c4sbpc6a6agzkd6b@skbuf>
References: <20241031173332.3858162-1-f.fainelli@gmail.com>
 <20241031173332.3858162-1-f.fainelli@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031173332.3858162-1-f.fainelli@gmail.com>
 <20241031173332.3858162-1-f.fainelli@gmail.com>

On Thu, Oct 31, 2024 at 10:33:29AM -0700, Florian Fainelli wrote:
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Acked-by: Vladimir Oltean <olteanv@gmail.com>

