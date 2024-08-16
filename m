Return-Path: <netdev+bounces-119295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D587955153
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 21:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20418B20B14
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 19:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD341BE861;
	Fri, 16 Aug 2024 19:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQWSFzRe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F838120D
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 19:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723836122; cv=none; b=b7TwL4CECfg/q3Bla0ak+3bzwZpCri/XfsBkHeQh8Rlcmpo9y+CwcT+83sMtYToKcnQObYLu6otuoSszEhzdfgjEDZStnN9SSY7b1f/0jxQ29VEZuGxy9O0+VuE1wudTOTXHRTzc0jHXM+Fb8CJMr3lvXRwPcnBL8iRM07NtrCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723836122; c=relaxed/simple;
	bh=dQg6kZbGItZWLgWofFdNx2Dx4bUJSRp4ZazpTufOW28=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jgCaGJLwIiQNR7EAmnPPwlVKKnm10VQ20GkqGKCWPjOizguIkdwwnuhYrB25VrPaTj/GtLm5lo96HEr2EJ52If7UBYoy73sJsx5uEPTlSfo+sWkaBYir2gQEJ1Oh3MQ44N6WCn7/yvRwCM0GIYv/ck4GP7oaith8LyP8HnVQDr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQWSFzRe; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6bd6f2c9d52so11885656d6.3
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 12:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723836120; x=1724440920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dmzyCH1KsSlILP3ArMdiZOD+6+ttdVWq01ln9zvyzA=;
        b=PQWSFzRe/lh+ZhYZNxGBoWlCeapoAGW/2yWgCI1NQxKm7SRlgaJBDliyA5pDHqwnXp
         1pzlgAZv+cjkO4tBRZmnCIJJD44x5az4WlKMVv1ma7OSXUJb0jA/V162HblC486Hnh3E
         VivB7DWuNmjdeMoAgFon51zoWwsROJMnTX2RZvVjWUG8HzZvDo2n87Xy2zkh3Mp/l6EV
         XK0+ZAsEOpCF+cfsCke46oKPHxvNorbzVj8Inc1xPB4XE53Yz6usg8Bh6Z63MNYArmb8
         jejPv/Kh4yV9T26YNEKVjPifrlGD6mmD87upsp0/caJSQv+wd+D0bpoarEBG7PEbVM7k
         9hCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723836120; x=1724440920;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3dmzyCH1KsSlILP3ArMdiZOD+6+ttdVWq01ln9zvyzA=;
        b=ZCAlsd68hBoXvuuXRAl2dXxbIFV7Kg3X5z2oxkqJpUVH4I0an09QbFfW/m5pGvSHwh
         3bzwXaageDGNTqWS3hPdBXZhnToylmypSDzluDJhNR55LH9yZ24Oadb4h62T1gkxtxZP
         f7jYzXOMJSt/YPPFVO2OPJXAN3GFPy6xpcU/qiDGbQjkYHuu/Iq9e1KAvlkgg7HD9F9q
         4ClzplTd3APteNao9ghZYweabF141sRVgX6Vio68n61jNNJ/3egFVSgMIG7jpJPkIceJ
         FblGVaYkWDe5dn9NP/ya2kajz/zgZHcYE2TbPiTU5bWURc/dCj0KznI+ikPK4uyKbQa7
         8eFg==
X-Forwarded-Encrypted: i=1; AJvYcCW22AwZLnGhpGkVXGuUxuZaPWHTePsxHDzJbJBIChwDl/Wr1fFQ/t4lDBnLHMPRfJ4PsJKQu5DLhQxMj0COIeZ8LuiTNftQ
X-Gm-Message-State: AOJu0Yxb8BIg0jFbMR2yhKKWVAK5BAnHmgIu5QDHfSniu2CVFweVOFu+
	7t+19Nti42hCIqYSiPae0TvB1YBdKk+F95DZJgBrc4+PZcaaPR1c7/yDBQ==
X-Google-Smtp-Source: AGHT+IEfnLiGKdq7ycuCRpIOKvend2Kh4h9IgSX+ZHTyKIe1gTxarNFPkqcS+GjuwIngcNF1OCfL4A==
X-Received: by 2002:a05:6214:3105:b0:6bf:7bbd:d2bf with SMTP id 6a1803df08f44-6bf7cd7fdacmr51546216d6.5.1723836120259;
        Fri, 16 Aug 2024 12:22:00 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fec5f0dsm20856496d6.86.2024.08.16.12.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 12:21:59 -0700 (PDT)
Date: Fri, 16 Aug 2024 15:21:59 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tom Herbert <tom@herbertland.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 felipe@sipanda.io, 
 willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>
Message-ID: <66bfa6d772c23_189fc829485@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240815214527.2100137-9-tom@herbertland.com>
References: <20240815214527.2100137-1-tom@herbertland.com>
 <20240815214527.2100137-9-tom@herbertland.com>
Subject: Re: [PATCH net-next v2 08/12] flow_dissector: Parse Geneve in UDP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Tom Herbert wrote:
> Parse Geneve in a UDP encapsulation
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

