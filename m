Return-Path: <netdev+bounces-62576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1204827E9C
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 07:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907FD285897
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 06:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D9B17C2;
	Tue,  9 Jan 2024 06:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+SW1tQ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E8F8F51
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 06:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cd08f0c12aso26984531fa.0
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 22:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704780141; x=1705384941; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mMX9eEXRUfpnrzzWAkP2KgaohNdQaahqdx8KryFbiyE=;
        b=k+SW1tQ9LTGqQAEuzfQDJ1975xbTBwbZMzdJ0+hE+ozPYXFD5yxE2AU7TCOIwZmFKl
         KWdTgVYoLgz8M9igYncampUBasF+0X391K/UkossClOBuuAUUj2BoyjUx892wdmMv952
         0br27yxuteTqcOt5xGs7RKeeI5BKcy1Vis3NP3UCjJRjRc1E9VwgwtEL3KikBjQgyFdD
         QeTZlS21uHSUkIVHuIkjTwZFJIhvVKzDzZ/q87FB4bKytO5Hnyls/wJ8+kny1+ehFhy0
         PvwpnuFUkV0sFVZSWWigVC7Ypz3GAmQY5jjvo1N7EpkgB/lsV2qfyPuj/Xhs16uqwhiU
         1Q6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704780141; x=1705384941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMX9eEXRUfpnrzzWAkP2KgaohNdQaahqdx8KryFbiyE=;
        b=uj14iy9uIEawsVTGsCgbzOAcBklfsmuJG5/RSzGCUxa+nypn3nitNTCRwTqWTkjTVv
         37VOLOyld9GxPBztmOB+XxWXRs8GBbyrXAV2HhDegUcGxh4nDv8qgIcC0MupCV/w2QsM
         jPaE0vsacDubci8SzSQCL78ynsC/4CM18WvC2SpdfHkE8N0+uaSsjysIA/2v3XubR/Vi
         gVIKhmYgUu+fOhY6ff4bNg6tssMW0CVrpxDw9VhMc48u0vHRfwEsE87XmxtGyjO++lr+
         +QKBCGWUmeBiJAVKxL3RxtPOJAS6CqsXNk49g6mc/uZ7Oj8gYICGk1sJAYxzPfurWQDc
         pfIQ==
X-Gm-Message-State: AOJu0YxiTTCOAWfLs4q/Kv1+k3KWLZu4DbfclIKM7aQTHtI5alaQiQZF
	zeHhjmc9jKsbLUs3KoTj3BKowSy0MUlKo47gaXZjPUld7/0=
X-Google-Smtp-Source: AGHT+IHflrV47wx1tXLjX29q/P64M+KZV+DffDpCDqUfHPAAYZYnXy3K0ryqY2Q0g+RypbvWIFF6dw3DRdIkqAo+ULA=
X-Received: by 2002:a2e:94c7:0:b0:2cd:307b:5bdb with SMTP id
 r7-20020a2e94c7000000b002cd307b5bdbmr1407551ljh.67.1704780140704; Mon, 08 Jan
 2024 22:02:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223005253.17891-1-luizluca@gmail.com> <20231223005253.17891-7-luizluca@gmail.com>
 <20240108143139.6igg5emhtdj2nh3o@skbuf>
In-Reply-To: <20240108143139.6igg5emhtdj2nh3o@skbuf>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 9 Jan 2024 03:02:09 -0300
Message-ID: <CAJq09z72HGxHEo81KOoadEkfgzXUXYC+3QbkOjJr2cX1Z-j65A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 6/8] net: dsa: realtek: migrate user_mii_bus
 setup to realtek-dsa
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"

> Can you please make all these individual changes separate patches,
> some before moving the code to realtek_common, and some after?
> There's a lot of stuff happening at once here.

Sure. I'll split into 3 parts:

1) change the user mdio bus setup code in place (with some cleanups
related to that)
2) move the code to common, just changing strings
3) make realtek-mdio use it and remove duplicated code.

Regards,

Luiz

