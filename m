Return-Path: <netdev+bounces-37381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E09867B520F
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 14:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 6D01A283E1E
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 12:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8784C15E9A;
	Mon,  2 Oct 2023 12:03:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A98A6AD6
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 12:03:33 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915761B6
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 05:03:16 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-405524e6768so143145415e9.2
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 05:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696248195; x=1696852995; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LkGgdFr05agRR4B9/n54lNLBLooPlkq4SUAidYLhpYI=;
        b=Wolcri6kgU5Qc8NbDttLdOi+YJVP8IAyL7xZzhV42/Xmg+ATKdedZ6+0SMaqPXXiXh
         fKsJD+TPDBXAkmyid0Er6lDrwprOS2SXvaLvI9P1ox40RNdUPVAfUCekehZTgW7vkMty
         Sn2oFLYu9M5GtAmWjUx7EHfrC1WXWLFBU+6Cf0DDSm+Z4cXDbaVDRQpkuVOyHkStPPev
         MLhkmIP9FXdZqt4zUm4K2MBhazMPAP28/xdVRo029Nks28xad44NiAYnjMLvkKzLL0TQ
         24S10Fcr1vGCnPwZq5B8Tw3WTfO9/LOT8XqT/0QgSTDNtcF2j8YoBcH2rmek5fiN0gSq
         4WeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696248195; x=1696852995;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LkGgdFr05agRR4B9/n54lNLBLooPlkq4SUAidYLhpYI=;
        b=XI4KzVr/QYWisvB2/Q5ZlzGykns224/RnQ4M0ldI4ekAqTFVBa7oC4hE+T7lQioTRS
         XsCtvXKE8CERM0P4yZv1TNOeNOpw59RH2ZkVCsI/HCyZENRIqPXBKXddWV2tjO6SiL0F
         JumubAxQRY3eNmbPHS7mpEQdsRczQqlayIaC4U8ZWRpH/9GgqzuWv3+LboS+yGuXoelr
         JnbcbDN2q/DazbF2gQXVeEAke56PTjHT74h75iyd9ZvmIdeBlH/UnqIX9Mc1UwLDlTqQ
         IfzG3yj3UvLKyuzxMHc1yg8tMIbfXToDsE4zNUXhCF7nwT6hdbFmrPW1Q16EJKDUqbqe
         BR4w==
X-Gm-Message-State: AOJu0Yzs+kqypjAXcBwZcdIH9W0/XJrQtkpEPgRm4hR3HFSJnTY9JkzF
	7MzqYAeJwN39HJk/2KeQUi3N6o1CIto=
X-Google-Smtp-Source: AGHT+IE9FUHMrtoZKhffiztFw5bKBWLPl7dm7AS4yyhSOQ3I88JaFMk5F7pcCTNkKZFzO1JAv4w0pg==
X-Received: by 2002:a05:600c:254:b0:401:b504:b6a0 with SMTP id 20-20020a05600c025400b00401b504b6a0mr10437124wmj.3.1696248194245;
        Mon, 02 Oct 2023 05:03:14 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c024c00b004051f8d6207sm7098834wmj.6.2023.10.02.05.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 05:03:13 -0700 (PDT)
Message-ID: <651ab181.050a0220.ad81c.9536@mx.google.com>
X-Google-Original-Message-ID: <ZRqxfjc7w7nPKhOa@Ansuel-xps.>
Date: Mon, 2 Oct 2023 14:03:10 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: dsa: qca8k: fix regmap bulk read/write
 methods on big endian systems
References: <20231002104612.21898-1-kabel@kernel.org>
 <20231002104612.21898-2-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231002104612.21898-2-kabel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 02, 2023 at 12:46:11PM +0200, Marek Behún wrote:
> Commit c766e077d927 ("net: dsa: qca8k: convert to regmap read/write
> API") introduced bulk read/write methods to qca8k's regmap.
> 
> The regmap bulk read/write methods get the register address in a buffer
> passed as a void pointer parameter (the same buffer contains also the
> read/written values). The register address occupies only as many bytes
> as it requires at the beginning of this buffer. For example if the
> .reg_bits member in regmap_config is 16 (as is the case for this
> driver), the register address occupies only the first 2 bytes in this
> buffer, so it can be cast to u16.
> 
> But the original commit implementing these bulk read/write methods cast
> the buffer to u32:
>   u32 reg = *(u32 *)reg_buf & U16_MAX;
> taking the first 4 bytes. This works on little endian systems where the
> first 2 bytes of the buffer correnspond to the low 16-bits, but it
> obviously cannot work on big endian systems.
> 
> Fix this by casting the beginning of the buffer to u16 as
>    u32 reg = *(u16 *)reg_buf;
> 
> Fixes: c766e077d927 ("net: dsa: qca8k: convert to regmap read/write API")
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Christian Marangi <ansuelsmth@gmail.com>

-- 
	Ansuel

