Return-Path: <netdev+bounces-204707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E2DAFBD8E
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 23:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40E8A7ABDF3
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 21:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBED287261;
	Mon,  7 Jul 2025 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sm20hst1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF641946A0;
	Mon,  7 Jul 2025 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751924012; cv=none; b=RIEK/TpDhJs+WYJToe6c7a7KDzO5CxI7PdOZqZf+wR3YWiajpvx0lSfkfDYdHcoLfyvTNjdiwFJpcx+Jv5ZGdvR6bSuB5KIAEIEqD/GyLpV85AltnRGRriT6NhhIhmAIFJ79BoXFCsz+jd6WGhpRJoK9ngC25QkmrMeBU+g95H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751924012; c=relaxed/simple;
	bh=IScrXANU3gy8kTdt2EolRmDR+MMV1A8bs6MmHNMAM8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bm3041ti1QV6U4zHP5TQqjR4aRag99GzwwFII47uLf7vopTpBjveRyt2T5VtQazSR+eCmJaOBB8bD4JdqtNwXvlr4qldW5uiaia5yG6B7vrz8lFgzfhruwvm1ZRcbW3cwMU8iaKYi5TzuvjiZuP779fmYSIDcdKLYF2NRsKCiX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sm20hst1; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6089c0d376eso499863a12.2;
        Mon, 07 Jul 2025 14:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751924009; x=1752528809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ltgx0FAElaI2g9x7RDxclBbvIyqiFXdyM4H0mdYW0U=;
        b=Sm20hst1Wfs2zt+sqDXCCHwh5x/t4Do4eS+hooTCnG8ma3N+rQRPvGF4HeePBNBtr/
         VUh/FS+9VCGsCz+9w3kEMfvN3QXfrpdV6FJH3AdkiwoDsn8egyOKvW7iyx8LmcfCVXdc
         sVhkf6SKm2HFp8ZY2R1R/SPNW9AUKZfb8uqRUPKAz68ksNQwxRc9/YXrXWM5lDr5sUen
         qAvNK/CGWBVK57NZukv/L9p+Xd5glY4wIDn0JsUUEBhKu2pJ5gnauuXrAbqiwIPNfIeH
         yV8ikYYBg4edsIKaWyKfDwfYrZEei55cD/xPlVNKIdxp3AUBCQ24DOZ/8EsbGQMP1Dpt
         fcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751924009; x=1752528809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Ltgx0FAElaI2g9x7RDxclBbvIyqiFXdyM4H0mdYW0U=;
        b=ljJStcDvVIHcYwJDL2KB0KjJZbTS2z8wPPT7v2KJskX3INwi77RmklQC9o6hHJ+0Al
         HG6fyj3vAOzCf2p5hbqDm3Akw+VVG53qjMET40Ll9xE2gBjWBYpVWaTVWCJiqjoZi3cw
         RWV7TwBMbc/0aXoZTmKRDtr1wbKFAltIHkMSg1YselP6rT0FoGEGlUx0BoJLx0IcnWUg
         8ymaMdKS34m6CEOKBNWDxXTJ2nyOh+tduEOZ3jsl5BOz1+q06UjUJPDcr1zhVw23KnJp
         jpIlNo0/AA1HbEKGqd+HTDKThvYCuxxh69SZfPmFbDULEn1ChBzGL8WGkdmwVGME1p6u
         Ldiw==
X-Forwarded-Encrypted: i=1; AJvYcCUftQgNrk7y07pKgBXyliLJ1DJWnn5rvB1RuNcOBncOLpnjFAJXazh912aTZggdSViBqp16loSE@vger.kernel.org, AJvYcCWc2cRNaz/NYynoWCWE9kk4O+R0uPsBLnWZpF0kI7xVyLu3ZDb3ATRfObAAC3W50M+LjrAOebRxy/sQhGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzetJ/zCIq+fEsel+BNRhd1W0szEr9sHqiePQHAEaLXEcP5d13b
	ZPqXEZ8ZEawX1nuXP7njcdfWg7OI93bpQ04MZdD/M+caRNdoVVl8BWoUjTEio76I
X-Gm-Gg: ASbGncuwrRWcQ2Q0URSKrZ74wAGJ/DSmZhNe8j9QmSSs0Vevbs8LKaSleRz6+5xdaLG
	MLbZMQk8cZGQop9f/Ui3OcYX1+50u+dFDlpx4C4co9KPzFwp7wF6jbvoBpZwuhYYL9XHDeuygsi
	+SnuwdSkJA8z/In/M4GQBt9Bw4x1GKzNFP7g8neYhz3XyqpiUe2g3HapibKI4yCQEUffnCJ/CI7
	QEIsj1QU2fJL2HsAZtDUGa0jPbVPZZJJBDLnOUc0D6mpvq10dE+GnA6AAw0MQihDWCNDGOm6oAr
	2ID6DA91ruxF2m35ECF32Ul0vvPnTiLlGsR2+4QVrwLeXkTDT6scVfg=
X-Google-Smtp-Source: AGHT+IGV0fT6r+q+zuljOpEhYhveEQHE8dmGQnhNroLSXtZqCz9n3C8gmfvavRHcFo6ioSGWCeSroQ==
X-Received: by 2002:a05:6402:524e:b0:606:aea6:15f3 with SMTP id 4fb4d7f45d1cf-60fd6522d37mr3938094a12.1.1751924008734;
        Mon, 07 Jul 2025 14:33:28 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d708:da00:9ed3:c5c0:bd91:c71c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb8c63f9sm6041670a12.72.2025.07.07.14.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 14:33:27 -0700 (PDT)
Date: Tue, 8 Jul 2025 00:33:25 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: kernel test robot <lkp@intel.com>, netdev@vger.kernel.org,
	Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: dsa: rzn1_a5psw: add COMPILE_TEST
Message-ID: <20250707213325.b42szcgiuqurrx3h@skbuf>
References: <20250707003918.21607-2-rosenp@gmail.com>
 <202507080426.3RX5BOHi-lkp@intel.com>
 <CAKxU2N83JjTG19_GD-9LPJfe=aY4tU+7dFjRhFqGeLDn6beGKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKxU2N83JjTG19_GD-9LPJfe=aY4tU+7dFjRhFqGeLDn6beGKQ@mail.gmail.com>

On Mon, Jul 07, 2025 at 01:47:49PM -0700, Rosen Penev wrote:
> so it's probably better to do
> depends on OF && (ARCH_RZN1 || COMPILE_TEST)
> to match the pcs driver.
> 
> not sure it would fix this error though...

Yes, you can't select something which has "depends on", unless you
ensure that all its dependencies are satisfied.

If Kbuild has the same operator precedence as C, then "&&" has higher
precedence than "||", and "OF && ARCH_RZN1 || COMPILE_TEST" actually
evaluates to a different expression than "OF && (ARCH_RZN1 || COMPILE_TEST)".
The former can be true when OF=n, while the latter can't. Thus, OF=n is
an unsatisfied dependency for the PCS driver.

