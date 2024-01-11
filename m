Return-Path: <netdev+bounces-63150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E92AD82B5AD
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 21:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153411C21254
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 20:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385DC56761;
	Thu, 11 Jan 2024 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBLD3yxM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F3756751
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 20:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e636fd3d2so1320835e9.1
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 12:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705003515; x=1705608315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ahYYkZR358AVuImX9h/FxjAqnr1ZW/9Bcn6OlnpBRp0=;
        b=XBLD3yxMkGUKIQMR+SeFPCMKgDQvjJetzSrx4rioDSKpFhEE+UAjn5HP+DFUStRKE/
         Tj8VdEuYaVctigpPxMLWP2VCe5cu4FkOqVnNhf1iSTBRjuGxjHA9MbrR37CqqpAuQTUA
         DchfQrcJyMFdeiwkqxL0hYfZnw6YPocGlmrgLED8QC0fSkROJFvJdQHtvttDHs9iJTFY
         4Oi0UdTx5VVdPD87GJ8adAgmp2j8tsm3GVbBVEVQi4GXChVbC/TqJ92AajnrbUXfxMPw
         KxA3lPs1KIPH6sjX5zf4IYHQcw0ae2g0d1KYrzFcds/IYGUn4uzu3hpf5tv5yjIUBCyP
         J2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705003515; x=1705608315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahYYkZR358AVuImX9h/FxjAqnr1ZW/9Bcn6OlnpBRp0=;
        b=UPNyFEdXakYcXIq5r4Spq5TLgIR9rejus7zoqhspBWWJUhgVq3GIRmjbnJ2cOFarOo
         B6sHaBrdFZhUutRW3vjHZUYOhO8mjaAyU2UWtLbcdw8CFTMnSSMTuybGpOE6LSVtGnY7
         GHnWdKQtPXR6i4rz/VxdbWqIb6rFnXLuGFtKnSMVqu8auvha7NwKa8zA/F1mhF/PK5su
         N//WnsX2huMHKTT9nz4QskmxFGv3ieYESy0IrD6fmM58NcAafMOzpVUnlNHZLjFUL/KI
         VpPlAjbOhW/6PdR9JmWU3oLrqCds5F/3iRXnESq2yBBxSDzvnpZjzqQAg7vlqPVv7fWX
         CDsg==
X-Gm-Message-State: AOJu0YzicRRojptHxSQ6pAt6rvmOg0nu/GLbk1+lkuzP+x84g817elec
	m6bPk80sADdS0vEMcRAjYyI=
X-Google-Smtp-Source: AGHT+IGUYaVGJ4yGIxoCuUIvzVVY1DATd79VN7Si06VvzXgb68pwbkLSA7sCkfFTpE018KxCT8mVXg==
X-Received: by 2002:a05:600c:63d2:b0:40e:43e4:a015 with SMTP id dx18-20020a05600c63d200b0040e43e4a015mr206361wmb.74.1705003514615;
        Thu, 11 Jan 2024 12:05:14 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id fc19-20020a05600c525300b0040d839e7bb3sm7074553wmb.19.2024.01.11.12.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 12:05:14 -0800 (PST)
Date: Thu, 11 Jan 2024 22:05:11 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com
Subject: Re: [PATCH net-next v3 3/8] net: dsa: realtek: common realtek-dsa
 module
Message-ID: <20240111200511.coe26yxqhcwiiy4y@skbuf>
References: <20231223005253.17891-1-luizluca@gmail.com>
 <20231223005253.17891-4-luizluca@gmail.com>
 <20240111095125.vtsjpzyj5rrag3sq@skbuf>
 <CAJq09z7rba+7LCrFSYk5FjJSPvfSS0gocRCTPiy4v8V5BxfW+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z7rba+7LCrFSYk5FjJSPvfSS0gocRCTPiy4v8V5BxfW+A@mail.gmail.com>

On Thu, Jan 11, 2024 at 04:53:01PM -0300, Luiz Angelo Daros de Luca wrote:
> What do you mean by dropping the "common"? Use "realtek_probe" or
> "realtek_dsa_probe"?

Yes, I meant "realtek_probe()" etc. It's just that the word "common" has
no added value in function names, and I can't come up with something
good to replace it with.

