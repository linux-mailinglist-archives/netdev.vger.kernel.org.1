Return-Path: <netdev+bounces-125273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D02C96C915
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 23:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84ED61F2404E
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 21:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E14146D6F;
	Wed,  4 Sep 2024 21:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHcNlKHe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5795038DD1
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 21:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725483845; cv=none; b=LdgcbtaNw74jXX7Op1vz4eWhNtxRnSE+i8I7ti1BWeuwfFg5qtFBMgkBGr5NBwrzePzgyOlymHgivajajwAXA5tnmPQykwQQfg8jRMequVfhmDnTMjhiLOUVB9PtNM3/wxNcdL8JppfnRdRxi3906i76iAhrYOghHGutZvkfYEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725483845; c=relaxed/simple;
	bh=Kh7IgtKfj3DXBCdwghznSxnNsexvkW2KO3KFpt8L/KE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iPQfxVabM+fCx8eADes6uAcUbhSC28gOZCTonQpCF1fQ1g29oz6+G6Hr7n1b2V8tGcJOEKT0PFh+8HjAN7Oug9nBUpcMImkp02ZtQaFOIYBAgziwajvSL245/6my9204wAkOiBxH6VwqZmwDC2Nb6u7APH9inydlOcPoNaLfQwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHcNlKHe; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6c51d1df755so264256d6.1
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 14:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725483843; x=1726088643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vA1l7sDT33AbY3uLO4NBQq9u/cga+O7aY391JvpfGqw=;
        b=iHcNlKHeLgNuCfkoucHfN6IAvAbRYN3KFEyNIF4iK4jAn4yJ/IMf9mlZEodZRy6z8y
         KwPrQYANOwcPqTdNPSsUz+EGMQ5/iGXDDh50D5RQZV2QyHMfv6XXilvCTOG9epUCYVnG
         UVSvlM2l+RfUAeRI1Y6cQz6nRkXWYR9riCAseuen9FJhD8gH1BSmJCI4PVqY0V+q/K+b
         VR7WNNGKEhcVaOGC55gYHZeenPjeC3iPWhJCxZ118bzv3E/Ff7RSo+9690aD0KHaVlxD
         DZxaBy3UygXj5n9v87IR24dx14ft9xFQcgVg8HBmmlToQNp5ceqiHWrJf6sjz8MHGslS
         xQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725483843; x=1726088643;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vA1l7sDT33AbY3uLO4NBQq9u/cga+O7aY391JvpfGqw=;
        b=eW7Gt9kyAOzLZ7d4Rva12muwZt2jcRiic7QLisMTW0e0fyTjSd0GfwAAndgYzdy9PG
         4ah9uf3NVnVuXo10tg8PEYdVG7FXICiZBel3ca2EfW6EZmqqDAzzOQN1ewywbFlPTte2
         dBCHTWa0l31HWjlihkrK+QtqkIlE36PWacnrwExZhEaYl9gRoOb27O0thg4W6vngRH0G
         LY1XE/HE9ogH8i17RG5i69baPFd+BiC9JlQLLpPX8iEFnXaxdFQvabxy3iibVXwEdtKb
         ZW0pKN0R1tsGDNoMCt6BRA/JJ5vam8kt6+9G/Sx4hJTETheWNm+6UbXldAxBZNWIy6HS
         7l7g==
X-Gm-Message-State: AOJu0YwNpTvgu1YcLAa+pPgEMos6rEJPG1nLs3SYpPWzXZMpRb1+bhpH
	sZDVWrCHMMCA0KqmbImzHykII6Zpqqg+Z9ese3Vg9H9HewOyXYZT
X-Google-Smtp-Source: AGHT+IFxrzR0A5sdIsR2fRiGNHqgE0IhMFDpR/3/uLsnk/ez5Whk0hh4aXlbS+87EItW5YIcECAsZQ==
X-Received: by 2002:a05:6214:2dc1:b0:6c3:657a:cbb9 with SMTP id 6a1803df08f44-6c3657acd86mr161428686d6.34.1725483843111;
        Wed, 04 Sep 2024 14:04:03 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c52031558csm1851836d6.93.2024.09.04.14.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 14:04:02 -0700 (PDT)
Date: Wed, 04 Sep 2024 17:04:02 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Message-ID: <66d8cb426bc39_163d93294e@willemb.c.googlers.com.notmuch>
In-Reply-To: <8a50a1f2-3b99-4030-9a96-6aecdd2841b7@linux.dev>
References: <20240904113153.2196238-1-vadfed@meta.com>
 <8a50a1f2-3b99-4030-9a96-6aecdd2841b7@linux.dev>
Subject: Re: [PATCH net-next v3 0/4] Add option to provide OPT_ID value via
 cmsg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

> > 
> > Vadim Fedorenko (4):
> >    net_tstamp: add SCM_TS_OPT_ID to provide OPT_ID in control message
> >    net_tstamp: add SCM_TS_OPT_ID for TCP sockets
> >    net_tstamp: add SCM_TS_OPT_ID for RAW sockets
> >    selftests: txtimestamp: add SCM_TS_OPT_ID test
> > 
> Oh, sorry for the mess, patches:
> 
> [PATCH v3 2/3] selftests: txtimestamp: add SCM_TS_OPT_ID test
> [PATCH v3 3/3] net_tstamp: add SCM_TS_OPT_ID for TCP sockets
> 
> should be ignored.
> 
> If it too messy I can resend the series.

The series looks good to me. The four patches listed in the cover
letter summary.

Overall looks great.

Perhaps the test can now also test TCP and RAW with a fixed OPT_ID.

