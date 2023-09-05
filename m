Return-Path: <netdev+bounces-32093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3815B792328
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 15:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42202811BD
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 13:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB75D51E;
	Tue,  5 Sep 2023 13:48:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E36CD517
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 13:48:43 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF29191;
	Tue,  5 Sep 2023 06:48:42 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bcfe28909so363106066b.3;
        Tue, 05 Sep 2023 06:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693921720; x=1694526520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ivI8ki1e5TGUUKYpVg+QTE/tjrcLWAvCLa+dhdl5XEI=;
        b=CY3j1AHeVNCevs0ooms++jx2DMipFFv4A+FTAGA/1qDIvzPxUkMskJEOlW7O4er9VH
         4JdhD+Kc4vas6EV4y0gHrAdWB0Jvt1UegrKsapIxtsZGQRZ8T7D1ye4jH2YkLDCSBQ8K
         49Yf5kudHvZDNpsDy/wL6kLVVgnhof+FoqVDR9jjty5rs5GFusIXYLsGJDMC9UQwFizK
         VWnzQz3urUG3xfduWAjfVWUvz3krAMtMsB3j9XyQ4ka5QxcKK1wYzlDpBD1mtLQz931T
         kS63lZvLJDa7b9TsILbs0euYnMTqfQMtgpqVHagPP1uQ0wj74RWqPoGat7QlRAu+ZfPq
         jjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693921720; x=1694526520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivI8ki1e5TGUUKYpVg+QTE/tjrcLWAvCLa+dhdl5XEI=;
        b=SZFP6RHlWkkQpxD1iTQTDYSPYfiMvFsS+MrxWjdh1CqW/BJ4UceBavoq+y+h3QdNjo
         7x1mbS+vk2z+tCSfh7ORnNkg01UOES0ZmynCdY2E/eWmC/xEGgmIMmxGuZDCEaS3cfmM
         Prcrh2u2a4DcdPyxvTqB37XJ6HI8iKenpGS9TMyYZNzQSzkXfkxbXvFjhrs1Fu7r0SNq
         vIP4S2XXYPAp0SA9B6LkuRIqF6va42NrAszPthilwpwceDqopITjYiAWajGfq0QyHXeW
         qBaDrzjwOTaz3S5K30s55OkY7KJVoKhVO4IZyqjoYJZOr1vUabNmYWCKi1SULFCmnB8z
         LxsA==
X-Gm-Message-State: AOJu0Yy2xne0jEfS4rCPN/q63RpE2iWGNv4UmJiVUfaql3t1HTWUlW+p
	HQTFBJkMnssebIeTrYSg50E=
X-Google-Smtp-Source: AGHT+IEUa6ooT0fp9TE1xzrdpb7voSWSn4UcmzmYyPMQJD4a+aEz8sShQeZ0Jsw+MpXrM6jeGbKZbQ==
X-Received: by 2002:a17:906:116:b0:9a6:4fed:e132 with SMTP id 22-20020a170906011600b009a64fede132mr4279516eje.55.1693921720372;
        Tue, 05 Sep 2023 06:48:40 -0700 (PDT)
Received: from skbuf ([188.26.57.165])
        by smtp.gmail.com with ESMTPSA id kg12-20020a17090776ec00b0099364d9f0e6sm7627262ejc.117.2023.09.05.06.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 06:48:40 -0700 (PDT)
Date: Tue, 5 Sep 2023 16:48:37 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
	davem@davemloft.net, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>, Tristram.Ha@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com,
	George McCollister <george.mccollister@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RFC 3/4] net: dsa: hsr: Enable in KSZ9477 switch HW
 HSR offloading
Message-ID: <20230905134837.dzp3yk2hjgt6hf4a@skbuf>
References: <20230904120209.741207-1-lukma@denx.de>
 <20230904120209.741207-1-lukma@denx.de>
 <20230904120209.741207-4-lukma@denx.de>
 <20230904120209.741207-4-lukma@denx.de>
 <20230905103750.u3hbn6xmgthgdpnw@skbuf>
 <20230905131103.67f41c13@wsk>
 <20230905130355.7x3vpgdlmdzg6skz@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905130355.7x3vpgdlmdzg6skz@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 05, 2023 at 04:03:55PM +0300, Vladimir Oltean wrote:
> > > What are the causes due to which self-address filtering and duplicate
> > > elimination only work "most of the time"?
> > 
> > Please refer to section "KSZ9477 CHIP LIMITATIONS" in:
> > https://ww1.microchip.com/downloads/en/Appnotes/AN3474-KSZ9477-High-Availability-Seamless-Redundancy-Application-Note-00003474A.pdf
> 
> Ok, so the limitation is a race condition in hardware such that, when
> duplicate packets are received on member ports very close in time to
> each other, the hardware fails to detect that they're duplicates.

It would be good to leave at least the link as part of the comment,
if not also a short summary (in case the PDF URL gets moved/removed).

