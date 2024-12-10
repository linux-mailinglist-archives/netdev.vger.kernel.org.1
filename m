Return-Path: <netdev+bounces-150833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB9B9EBADF
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE78F167308
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 20:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE2817B427;
	Tue, 10 Dec 2024 20:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KL4k9T6s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041344964F;
	Tue, 10 Dec 2024 20:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733862720; cv=none; b=Mg21G4Lg+Vm0U9nUj5IdtQ6k3Yq/2nUSbPnfBYtDNCsDf0qIHgJEc6w1Oxb2CqewrWVdAlf/LAtLjyDLqTXDVLU/TW/k3k3hnV3qVtXVIy9kan27xhDFkaukb7Fy+EAnUDwz9Kjq9KerYot1IfzlTuq5NQYOho0WVvDS1VuSYLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733862720; c=relaxed/simple;
	bh=WrfF3ihMgm7HLbBCTJxw/Qkq++9KZ890JxylLd2D9wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iK9tPZJbjONfCahvB//sWOxN7fYdTrqNdZHFV2ToAUp99YWtNvSuySnM1lotpVPvCyyyJw78Fkc43+eNaMKBDgmK6RBiiab7AusqOz/fzhj/jEbZQSLttdFn3Z4azxijgUG4Sutz/tP0tFFXMZcdkqWwXv/z7to8kT7/YL6VwCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KL4k9T6s; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa680fafb3eso36346066b.3;
        Tue, 10 Dec 2024 12:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733862717; x=1734467517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WrfF3ihMgm7HLbBCTJxw/Qkq++9KZ890JxylLd2D9wI=;
        b=KL4k9T6slCbrbmlu4HIdDBaYdiwhmrc/twJa7tpVFBdGWB8a+0JgTiurl2f6McyBkB
         bzQXpakWmPFBt+A5bpqSEYIjZ0N1Ex/ZzdvULHIx49mj7CVYCbu1oT0u2nP9IUmW8ivD
         i8IyQsqG9/fP0TlmgJKcTBokDUzZSdqO2iJaMLKOYmMje+1nERV4GrQ6ySvk/79AcKYU
         40Pu7mlpB9lpDIUH2pXuvT9cCa8TMvxmigys2Dsg4LWNVevG2oRhC18J/6gLSfJ1NwHF
         x2H6V3c990bLRCOOIFanilSUYaYkoTVnT12QHuT528c1HCdGPxQQrPVAY/7XW55R88uq
         /TFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733862717; x=1734467517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrfF3ihMgm7HLbBCTJxw/Qkq++9KZ890JxylLd2D9wI=;
        b=JS/LaE9mMkS4jPoMa3dw9Kov3xHoDL+RlWNevy0wP5w0a/CGgMdX0/JskwiDkrkFFi
         wOm7crEjBYDMLdKIbM7URUUbdqF9lZNN9roQYKMi2Rfoan0zQE/lyjGV/MhnQwpVIR1T
         /ElH0B7tOckgwas0r+MsHX7R9x7ZF1UjBr8MOmDBXT9Mde0zMdGhMitXOrjwvhoY99UC
         zTzgFWMIQTXyXpw1BfbqCZOqF7lCj4bRuJze9+B9/ffI6fzNK/mOZUpf+dSUyefAS1i5
         O/3eX8a0t0ikcJPBpQmtqd4vBLBXE/teWJViWCmLc1VOc0LzunsdIP8iuBOXBPjLhlwh
         4X6g==
X-Forwarded-Encrypted: i=1; AJvYcCV3Dx5e0taRRSblwHBUrH+1oDAZIlc6gJ0I8nkeHFxyWOAqPHwnkzXXOCVmPs6r6i2U6P41b3Kpolnq8gc/@vger.kernel.org, AJvYcCWg+8BBJzpUiJl+JwxNKwSIm6MCc6m81TLnWPpUiBZkXPQRTRZjqCKFK4r6X3Ghfz4X7d9/Fsfa31NY@vger.kernel.org, AJvYcCWx254WCKdmRVFeYHgu6qow8WdSFm5tRLwRlVIvlvNU/YAjL6eKfepEbV2uJHUJMKSTv/UHXLpj@vger.kernel.org
X-Gm-Message-State: AOJu0YxIWzSdWOF6CqKZkzZ4aKIi4pkWvTZ0ympDBYctKg7G0Ljyw+ZK
	C/Mpd1hvXpWCfTM+CLFHF7x+Tx693cnb8yJ4m0PoFRhsMfNzib3F
X-Gm-Gg: ASbGncs7U8oL5TTmrVIMFZtuoeorIvSaOcufVfYJAT+o9BFHz7E/aFbjuTuQ+EW26kt
	9qAHyv0p4sepTtno4nHIzluA1ppUITE+TS77AD7UbVUyEzQbyxVFxq9GXA9NmC825fG4DDTazLa
	X9F+MPDwuppDuaBUpMjWRoDPjiHGzgE+4lkDWokNhcuSXjJq78ImMVyUpu8PkLrgG7PDtXs9loV
	KE5VmstLVOa309POmt6+Kdz4SWJq7Fs48sCIfYCjw==
X-Google-Smtp-Source: AGHT+IGLd9lb1MnTFb9FekQ5wROKKkUzu6IDM0uQo95hunfTcUvUs+mTTcbU+ECnXxVHJ4JQmDDN5A==
X-Received: by 2002:a17:907:a08a:b0:aa6:6792:8bce with SMTP id a640c23a62f3a-aa6b10ece1emr7547866b.3.1733862717125;
        Tue, 10 Dec 2024 12:31:57 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa671f14766sm489524966b.169.2024.12.10.12.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 12:31:56 -0800 (PST)
Date: Tue, 10 Dec 2024 22:31:48 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v9 3/4] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
Message-ID: <20241210203148.2lw5zwldazmwr2rn@skbuf>
References: <20241205145142.29278-4-ansuelsmth@gmail.com>
 <20241205162759.pm3iz42bhdsvukfm@skbuf>
 <6751e023.5d0a0220.394b90.7bc9@mx.google.com>
 <6751e023.5d0a0220.394b90.7bc9@mx.google.com>
 <20241205180539.6t5iz2m3wjjwyxp3@skbuf>
 <6751f125.5d0a0220.255b79.7be0@mx.google.com>
 <20241205185037.g6cqejgad5jamj7r@skbuf>
 <675200c3.7b0a0220.236ac3.9edf@mx.google.com>
 <20241205235709.pa5shi7mh26cnjhn@skbuf>
 <67543b6f.df0a0220.3bd32.6d5d@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67543b6f.df0a0220.3bd32.6d5d@mx.google.com>

On Sat, Dec 07, 2024 at 01:11:23PM +0100, Christian Marangi wrote:
> I finished testing and this works, I'm not using mdio-parent-bus tho as
> the mdio-mux driver seems overkill for the task and problematic for PAGE
> handling. (mdio-mux doesn't provide a way to give the current addr that
> is being accessed)

The use of mdio-parent-bus doesn't necessarily imply an mdio-mux. For
example, you'll also see it used in net/dsa/microchip,ksz.yaml.

You say this switch is also accessible over I2C. How are the internal
PHYs accessed in that case? Still over MDIO? If so, it would be nice to
have a unified scheme for both I2C-controlled switch and MDIO-controlled
switch, which is something that mdio-parent-bus would permit.

