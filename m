Return-Path: <netdev+bounces-53937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 498218054FB
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 13:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016992809CD
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 12:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED995C070;
	Tue,  5 Dec 2023 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnqPYWWf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0F510F
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 04:42:46 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1cdeab6b53so51600066b.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 04:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701780165; x=1702384965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qmq4l9ej1A+DpZ4jngQfqL9Oiy2fHxFTbCGet7aE4Nk=;
        b=XnqPYWWfDmJy4rQN1Bo2AFbtzS2Tc97o35q2D1exJGO91NbeZNDgNQLq9EGbVjDTkC
         8tf0pAyykThHRuOFkwhzDkbdBoIrRy+/U1/etL0CSZpOgUhX37DO4Ba4L7NbUntIqT1I
         dvwToMmJsDOwwK9HlQ4HhH5hyIC5omm7Pfvwz+jfnfo1PhhLogXnsHPezHzbOMO/wdSK
         6n2DBQ/TLW0ezf2IuzPdnwDVrkDTFu6hy3bDvriTb7EerjiyQBON26Qgoxdcxuoc2SX+
         iGEWx+xdnzl52EolBpOA7eqRckFRt5+lXyswidkUeC7DlvEuKhA/Ga951GcUH9+pHgxm
         gnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701780165; x=1702384965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmq4l9ej1A+DpZ4jngQfqL9Oiy2fHxFTbCGet7aE4Nk=;
        b=DnZ4DPfd94T2LLR4IceJbpA0fPf3RPL4mcwNnlZPtME9k3cZ9jE8A8ogO1lToRrx5g
         CXbi/6Y2qvD4jB9aeHBma4wOCMM5vwpwSU1aYDJf5w27MSKlyP92ry5TQTr0p444mIS1
         aan4B/gDn2t+s42E3Iy5KwppiAKOAB4azze1PmDhY8ulsxgzjd+fq5XB00AbhbN5+CUc
         NpxUpa4givyrmmDMHQmjv5fJqEFAqO3eOLwST6qCI8rmFFydLl3JAewrmckJMQYq09wB
         TVBlXKBU1o2bf3ghsK1GpMx7f5ZTN4ZEcY8g4wwAIfM6T3fwTl/LV+Ag0qcQHmTBB/xV
         o00Q==
X-Gm-Message-State: AOJu0YzeOz/PJ5oBzeDstUcpsJVb8yCxS3WwZZ6f8Q6M2yRAfrg7BdZv
	Yy2vy6gbexDb8FPbJfAMCKY=
X-Google-Smtp-Source: AGHT+IFYjOCLUwoWmAJKWioPNJPEQtJ5msKJdOqLCGHmz7xmjLzmsqC1abuQdus//5JZ8kictb77Hw==
X-Received: by 2002:a17:906:2c1:b0:a1c:7671:8806 with SMTP id 1-20020a17090602c100b00a1c76718806mr710090ejk.0.1701780164909;
        Tue, 05 Dec 2023 04:42:44 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id l14-20020a170906414e00b0099c53c4407dsm6605006ejk.78.2023.12.05.04.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 04:42:44 -0800 (PST)
Date: Tue, 5 Dec 2023 14:42:42 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Danzberger <dd@embedd.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] net: dsa: microchip: fix NULL pointer dereference on
 platform init
Message-ID: <20231205124242.tovrlw2s5gfgbceu@skbuf>
References: <20231204154315.3906267-1-dd@embedd.com>
 <20231205101257.nrlknmlv7sw7smtg@skbuf>
 <db36974a7383bd30037ffda796338c7f4cdfffd7.camel@embedd.com>
 <20231205120421.yfs52kp2ttlqkwlb@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205120421.yfs52kp2ttlqkwlb@skbuf>

On Tue, Dec 05, 2023 at 02:04:21PM +0200, Vladimir Oltean wrote:
> You can post the 2 patches as a v2 of this series (separate thread).

Also, for v2 please remember to use scripts/get_maintainer.pl more
diligently. Would it have been a busier period, I would have probably
not noticed your patch.

