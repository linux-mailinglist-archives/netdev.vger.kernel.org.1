Return-Path: <netdev+bounces-56002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC97380D38B
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 18:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70631281A85
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC514D592;
	Mon, 11 Dec 2023 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFJPeWCI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F80AC
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 09:19:42 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a1e7971db2aso538538866b.3
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 09:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702315180; x=1702919980; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dizyv7BkN0T6kwvBakPAsuQ2jacWYHlV1CSclkTsDic=;
        b=iFJPeWCIqmwGgRdaKDr4gQ3U87OTNckQ14uc26gY4fZB78iR+SPzJpmEhu3b0dlRt6
         MP/dv7a1CeR3up/x7fu6QGiHI9pZ+uMiXlSOXc9gH6PDTWfsq8YG4E8Tdvnwy316FYKg
         Zn7lJB/v48dSSQLycHPQn8R4JwTh0QFE0RHhQQWgL3umgYQwqVkHcl0JGJ0f6QDOOGb1
         vjjr6bWflUHZNMOHr1dN8w143fu16C7EBgc6hD7Ev7EKywt6l8no3vZFX3P7CvUBnzI1
         KICQakuPeU4fBEuAuIJI4dGhzw8ibSPW1Utkhaku+wBF6meDwL4fdKHpasHTZqg8y0EA
         3ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702315180; x=1702919980;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dizyv7BkN0T6kwvBakPAsuQ2jacWYHlV1CSclkTsDic=;
        b=stUE09j+M92mrQEF/QoviKbVkFVS7QUt0AnELeu/6vmRPLLcuSyDe8KRTAYyeLRhUp
         QIncVXNVcDyO19nAJlfGNji93j4/7NHBmYDXVfs90As7ntNIODNFiGygnptCT2odIrHH
         t5iUUBSQMDJu6oFoxjCQJbWJPtp/Hghs0QPwUPvALYHXi+TwuXA40suWbgBI/L5OkjAA
         JiXhEwzcYA6hGoC6Ln1w5HmI32ASOzXUkZs28LxGY42R/E1dJv86kzBVatre0LHPjhH1
         /mbYzirHe3YC9jFFXly0M4CudLyJctJqzFruFYjxrtrpN90baTK/nGS9LV+Wa5YRRECn
         Ja1A==
X-Gm-Message-State: AOJu0Yy8i4HgzD/3wr6hDaMWTV9brao139OZ8tVdcRpSl+aOjWe3Yeqq
	3A3oBOPw4TuQPdDKihl0eS4=
X-Google-Smtp-Source: AGHT+IHWux4gfD3/DAFRBdG/2oLLACFqkzC9GVT83MbmJplthkVYhcXtKp1R1WbFFHjTmAp+7/B4Kg==
X-Received: by 2002:a17:907:1745:b0:a1d:da25:1acf with SMTP id lf5-20020a170907174500b00a1dda251acfmr2318921ejc.153.1702315180283;
        Mon, 11 Dec 2023 09:19:40 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id vk5-20020a170907cbc500b00a1ce56f7b16sm5095488ejc.71.2023.12.11.09.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:19:40 -0800 (PST)
Date: Mon, 11 Dec 2023 19:19:37 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Alvin =?utf-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Subject: Re: [PATCH net-next 4/7] net: dsa: realtek: create realtek-common
Message-ID: <20231211171937.zb2rw2i7um4s5vnn@skbuf>
References: <20231208045054.27966-1-luizluca@gmail.com>
 <20231208045054.27966-5-luizluca@gmail.com>
 <4ltsthrk2oli6ickjiy6uy3pc3kpdddse7lab34qefbadjafhy@oaxoemtrhw3k>
 <CAJq09z4YtJPnpLb3OqYaGdiPU3zPO636tu=jG08a=ROD0A=dRQ@mail.gmail.com>
 <255k4l2u45si3k2o7ulcjaej7k56cgacut6lacumobywzvycm5@vvpswdlqt2gs>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <255k4l2u45si3k2o7ulcjaej7k56cgacut6lacumobywzvycm5@vvpswdlqt2gs>

On Mon, Dec 11, 2023 at 09:24:35AM +0000, Alvin Šipraga wrote:
> Yes, it is exhausting with this back and forth. Please just address what
> you are willing to address and I will review again. Thanks.

Alvin, I really appreciate the time you've put into reviewing this.
It is very helpful to have you around.

