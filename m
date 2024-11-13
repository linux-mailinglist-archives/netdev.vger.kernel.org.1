Return-Path: <netdev+bounces-144608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3B09C7EDA
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 00:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CD98B243F0
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 23:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF71618C347;
	Wed, 13 Nov 2024 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqWjA8MB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3FD18C021;
	Wed, 13 Nov 2024 23:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731541143; cv=none; b=XMAHVPKp/vTTv5/N/cZ0o0zh+wRjKcnky9qGW/vSWcrtTszxBU/+x/qoRqp/ncuJIhdA2vxzFd+WdGMms9HWIN+JKYdVrpKOphOlntmytflCUILRtBMjkYodSQ8MXfbWfT9oSnvo+jVcQbyRp1aWfEDU6rTnJK1gLQsy12H9Pl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731541143; c=relaxed/simple;
	bh=ueBCMcSTBPe1Fncu4AbM7bwieutTr4DTi49QfbuaRDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhNabipVyEvILsnBiNedhETzH2vtyL2D/AC9Al22CAjHPoJJiSmppMZ/XeQKo2Eyl3nQ2L45pHNgdgRISembQ5fg+OhLKbzXWvDFGNFMepWwVtp5Fry6KPMW7tCljOfhhdAGUa6nyKk/KsBz1zM6gB8ANW4v/bmFw9vhS+svehg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqWjA8MB; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7eae96e6624so5249669a12.2;
        Wed, 13 Nov 2024 15:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731541141; x=1732145941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4XVgw/isEUn2k+c98cIf6usFRo1mES8IsCKFY6HZWDQ=;
        b=SqWjA8MBL11+dFADPi0OhbdeC7QuK1xX9CRe2s1y0kr17T3KJeqZMVx3qs3YSWT6vH
         Cm5jCpP16YBCSiVk9+SfMo5M+8XesQN7DNx6nEtmsO6LB05SB62CV7vul/TJd1jZ1shA
         Doc0KVCtBGfl6N2VBTCaKDTqr+8H/0i8Vi0p8pKWdwQKFo8w/jTDQ0bug/Xptd7s5vld
         qtyrlGFoyro0XU03iFYWvoVDZZUpYK8uotZNZdleNn7f/F7MwysBxICFlW+6NIAIpPtd
         Lfn2erQZrCfkG0srzuFwWl0Kk+7Lgz6DVovSSEL0tP3N4LkcuPI1cDcuAydosr9SSu5J
         h6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731541141; x=1732145941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XVgw/isEUn2k+c98cIf6usFRo1mES8IsCKFY6HZWDQ=;
        b=hlUGpWiaqOxJxL73MPs+M/+SOf0qsuw4I+XqbslOjhdyLz8DCn+VH3jBB8de5mz5ed
         N7jjSmuqeuQnoqXcZW/6sNLU0qmh7O9j4f6M9h+gXea6Poc60n4oR2PhC5IFSO302FAe
         mM/JXiBVhXN/QniBSbdKJTRXVbmnYCNukhSZ69zOS8Xk1+jGd+6BpcDtCnL/ExOWUGQR
         gMkcInd7+JRIZVh5d1Z1AkFQhC9+gjCSnk/WGGYG+6dVqElyor8G1ItX8U10cIQpGi5C
         gz3jGNQjuL7u+yelm0sl4234RmfLY1JPnD+0pdjQnNEMZSOIlw6F0jYVtTpTfJae19Vo
         36Vw==
X-Forwarded-Encrypted: i=1; AJvYcCU/M+E19yMMkRaAIeKR8GixO/rE2kY3qHQLUo+oEYYrdBPnAky8pnmVXWlQMCVBCS04bn73t/oO@vger.kernel.org, AJvYcCU1qJo7IKc3YB/YrlyXmGv1myo8k0JzTUFMTS/pj04y3wglQ6O7AS23S4/3+JlFWIrz8nHJjLDJNhe7ghE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyVUACnXNAIfh1uWW3rsnbDEi+covrCihCp14rli5fY3fEF5KO
	0LwZ+fDbh3v26ppkvViEVca7Z8LuOQrcJMLf0D2svheoor+ImA6pZJ8FkBA=
X-Google-Smtp-Source: AGHT+IFD8EXO7+VwyKxyyy1O/es/cJLZmG5VBakgUIDG7ZhVxFj89OTwru58IqiuPdIZKVlBl+9tuQ==
X-Received: by 2002:a05:6a21:7886:b0:1dc:5e5:ea65 with SMTP id adf61e73a8af0-1dc22b60950mr31882111637.34.1731541141530;
        Wed, 13 Nov 2024 15:39:01 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a5ebb6sm13855747b3a.179.2024.11.13.15.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 15:39:01 -0800 (PST)
Date: Wed, 13 Nov 2024 15:39:00 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, horms@kernel.org,
	donald.hunter@gmail.com, andrew+netdev@lunn.ch,
	kory.maincent@bootlin.com, nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 1/7] ynl: support attr-cnt-name attribute in
 legacy definitions
Message-ID: <ZzU4lNqhu43Wagjh@mini-arch>
References: <20241113181023.2030098-1-sdf@fomichev.me>
 <20241113181023.2030098-2-sdf@fomichev.me>
 <20241113120315.303d8ad5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113120315.303d8ad5@kernel.org>

On 11/13, Jakub Kicinski wrote:
> On Wed, 13 Nov 2024 10:10:17 -0800 Stanislav Fomichev wrote:
> > This is similar to existing attr-cnt-name in the attributes
> > to allow changing the name of the 'count' enum entry.
> 
> why attr- ? we have similar attrs for cmd and we use cmd- as a prefix,
> so I'd just use enum-

Mostly because I don't have too much state on the spec side :-[ Did a
copy-paste from the attributes... Will switch to enum.
 
> I'd put it into genetlink-c level (you'll have to copy/paste into two
> specs), all the non-functional stuff related to C code gen is in the
> genetlink-c spec
> 
> Please double check Documentation doesn't need extending

Will do, thanks for the pointers! The doc is definitely missing.

