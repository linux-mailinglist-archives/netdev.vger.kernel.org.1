Return-Path: <netdev+bounces-152438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE2F9F3F87
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 01:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9319B1630C3
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 00:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98217288B1;
	Tue, 17 Dec 2024 00:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyZj3CFW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED09250F8;
	Tue, 17 Dec 2024 00:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734396477; cv=none; b=AxRqWfSeBVJSiM/GhjZmtSIuh4DB/u3uS7IEVRzuVnsnKoXzavKltRodb5V2RU2k1I+07gI5cY9PyK2oxSUnV5HNz7nBGQf3h4GMuIAvnZIPjBfGZmTlnjW3AdywZuY+P1MaHy1qgumYkCq4qG/CZM420TjC/CJ/XDynky3PrwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734396477; c=relaxed/simple;
	bh=RlsgdpLC522Yj0W1svIUqZZURGBN1oFBIzQeZa9+3t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgxD5ifQZzRdUyNr096hK2QVxFbzbY9rdE9BFIVNxTsQVXitmn2lSJ8WWe6lkdn6ehydydOvoZxmWP63WTSNALek0Q1SvNuXAwrVgwTOpo0Pn4DpFetQ1NZslsrR2Qqfo/18unsJ/6LVku6Mrzhj+QMVwjuK17owhwrfNmyjv8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyZj3CFW; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46772a0f8fbso42388551cf.3;
        Mon, 16 Dec 2024 16:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734396475; x=1735001275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RrUU1sA/PquF8Kcvm4irBd461MDD9nPT0JTqTCo4L28=;
        b=hyZj3CFW9QUs/uK+kQepy5OeABzPEe06/jqhdsLrldFSo9Qer3L1JzDFE8WlSIw1q0
         zsxv+q8bze5MccKByBdVB4nQBJX3tqq3zc+wZfkgA9iSmrt7t9Z4hhMyZmqLELr26ESJ
         r2oDUuB9+ZeqPWbCk03Q0xwdVHGr1d0kvYxbaXC9orfoiGsK8eKo3WGxkqSihsV6cjM9
         7sdlQz5Gq/zE+ANFCmyfJAvtGaCSAkCPRW4DtAVoTHvilvaOh3OhJuK7C9xs9HAKOCqD
         1RsUdc0uUMUwfs8FpPj+OYRwStf1DdIm5MY2S9z6j9d2TcGjSf72X/BPDcKc88ZI/2GH
         Y+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734396475; x=1735001275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrUU1sA/PquF8Kcvm4irBd461MDD9nPT0JTqTCo4L28=;
        b=XrNsZ7uf8kA5Cgg2U2KloLyHGDitW4J9J3NTK2dRmLMQygPBQDrmkJrLBklmtrHi5Q
         EQ8xQW1TT0jP6GVhc5JEurI3X1qdJcIvL9+Fi3Pe2FT8S8TRlgcqoJ8y7DvejUJ8EZYM
         rKREpzfVxdfTNjVlz/87CaczRF6I4oqnQin2/oPnyqdhXut0jQ7K25SS8iykZACUt20u
         AOBnwOAdfkybMROcbm0sQjibLTBOZ4nEd0D0J4it9tss9Jj8QzDAEdG8ooKnC8/9lhCq
         r0Q2KSn16rzySgoPCQpDYj3Vb+RFBMa9AcOoFFTXxxq2dZyI80p8hMuRYu/38nGqUEA+
         4j0g==
X-Forwarded-Encrypted: i=1; AJvYcCUFNURlbBKCKtl0VPjJWxQaYh8kXA/7OzcJRhK/24Yr9Ey2zjBdmMU/Zy7Cu2RviX68ULBj0k3+hwEq@vger.kernel.org, AJvYcCUpudS6Oi047TvJcOYXuEFIl0scxxL35FjhJbCh8hwzkxEgpCzTphckoHL/4piWZKs3uQkLz6Mv@vger.kernel.org, AJvYcCV64saUQogMlSf1gW2Rw22RyBQMnCfp9gaC5gtOhw4rKJsysOekcWC5zWGdJvYBIMiXZ1ArLShVAHiUnGTN@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuhm11IT0sDNPlJwmpcRr6nlwYsTJ/S//Bhk1aGNXKHMhrED1p
	0Y80AAYOxvLn5bGV5u4LbGeKBkP6Z4CYS+UJ/xfMLgp7uk7yQsKW
X-Gm-Gg: ASbGnctTM4J4oFI1oEllU/MQTvfL65CikdNdWbyVOJIXATAz2b3eWfEK1nrzrGq7RtV
	0PlXnsWpHNDYkT663zWts889ktyLGsl0pZ5/ZtGOnXwsdTumeADn/xsQu8QoYaUONJjOQ5l924+
	AWvZiG7yhcIv+lsIPBnCPL6KSNkjXEaukswei/KKaiyfqU0pPnwoavyWjBmev+Puhls3sfVWM8q
	EwlvZYV83fZMTXlV5tZdYPeFNsg3BX3
X-Google-Smtp-Source: AGHT+IHkNqEBTJEhiLtyWa2CGVz+1od1KR/2tzYm9ObLc/fC9+AGP2+40XW+DImZ8NXvMV8LHBW42w==
X-Received: by 2002:a05:6214:19c3:b0:6d4:36ff:4356 with SMTP id 6a1803df08f44-6dc8ca74ec1mr289693926d6.19.1734396474867;
        Mon, 16 Dec 2024 16:47:54 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd38078fsm32822106d6.119.2024.12.16.16.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 16:47:54 -0800 (PST)
Date: Tue, 17 Dec 2024 08:47:36 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, 
	Inochi Amaoto <inochiama@gmail.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH RFC net-next 0/3] riscv: sophgo: Add ethernet support for
 SG2044
Message-ID: <puld3vngm4rti74aecpeoro3tatifgasrq6sxg4huufuptmjtk@njfskna3k7ds>
References: <20241101014327.513732-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101014327.513732-1-inochiama@gmail.com>

On Fri, Nov 01, 2024 at 09:43:24AM +0800, Inochi Amaoto wrote:
> The ethernet controller of SG2044 is Synopsys DesignWare IP with
> custom clock. Add glue layer for it.
> 
> Since v2, these patch depends on that following patch that provides
> helper function to compute rgmii clock, and this patch are marked as RFC:
> https://lore.kernel.org/netdev/20241028-upstream_s32cc_gmac-v4-4-03618f10e3e2@oss.nxp.com/
> 

Hi,

I have seen the dependency has been merged, is it possible to 
resend a normal version of this patch?

https://lore.kernel.org/netdev/173380743727.355055.17303486442146316315.git-patchwork-notify@kernel.org/

Regards,
Inochi

