Return-Path: <netdev+bounces-52155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC8D7FDA55
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 15:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DA95B20BEF
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 14:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F69432C94;
	Wed, 29 Nov 2023 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="iNL69Sxc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC7EB0
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 06:49:59 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5d2c6c1ab66so3189817b3.1
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 06:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701269399; x=1701874199; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GBVmtf+pEAhHK7I2F+Ytjai2puTODpIPPuOMjFTo7A0=;
        b=iNL69SxchuyCoaeChrALUkMLaMxf0RGUZLBhHlIv9fmyIid1WISnt96JvYviUTKYc+
         isJ8c3GUmJUE7XVjMp2ec/xUlqMG2pnKLZyTDPwBQ7L3YPTLxhmnZK0jHgDsXI2c6KkX
         y/h30017MAqAHmfaQhqt0XQJCKAcFEJw/wD6VcmghDD5Vppj5V49jnr3DFwXk53Iu/Qo
         kUdaFU3XIBdpJo4rurlPVPDoGoWv9pxUL04PcVKA35H8ypc7dYp0A+6gFQbm0cCZieTp
         5ATOQRV6HTP3Y7T4bbcc0jp1zmp70AGEk02XarLdPyItTk6T7Qq+eSNwu2efdvWLd5gY
         SuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269399; x=1701874199;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GBVmtf+pEAhHK7I2F+Ytjai2puTODpIPPuOMjFTo7A0=;
        b=RW/MhI4OavKWKwa8+xGpmNQx0QTo2oHOEnCI0yLKNkm9t74nRur7XSmlMoNBK/6Eu+
         uvik7NPq7uxHBtkKi8rKtRkCueY+QS7cVK73QQ13qIGvJQkg7Vdn8UB7EpvzF8AC0Bcg
         z+qPSJXT+MOZUhE67EB2gP0LTHD0RvFwUkpUCN0wVTwIo4LdA/20cmF1dmLKmfTh680X
         qOfXU/TLpLOiGVyJlRwVdI4M5a4pLW1LUpLwcU2Yi3TacRAjDtLoiisJBaY4lpUBA4aM
         LJWgxW31kK58y1lOd4iG/EmcpxeHnCSeC9C/MjadAH7kdgx+XZdAsAtr8DgMSEbhXjMD
         MXTg==
X-Gm-Message-State: AOJu0YykK+D4p5rUdgHKBreTnu9aSEsRVuvf+z+HQr0ErnysktWBXn+M
	alv7WCZUfd3yiDsRIB/PLuglmBy67+rZWZH3t/Ulkg==
X-Google-Smtp-Source: AGHT+IEtV9F28OOOy9tH3l5iKJWwjprQlkElNpHIszdVzB//3E790Ju/odOckePER9ThQpFV/1OQtz5oi90x/tMd6LU=
X-Received: by 2002:a81:924b:0:b0:5ca:4b49:66d2 with SMTP id
 j72-20020a81924b000000b005ca4b4966d2mr18512140ywg.17.1701269398817; Wed, 29
 Nov 2023 06:49:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 29 Nov 2023 09:49:47 -0500
Message-ID: <CAM0EoMn=EMVDZTo+NR4JwJsb54jk6GX6+4r8ZkGnFULj=e4BtA@mail.gmail.com>
Subject: 0x17: Slides up!
To: people <people@netdevconf.info>
Cc: program-committee@netdevconf.info, 
	Kimberley Jeffries <kimberleyjeffries@gmail.com>, Christie Geldart <christie@ambedia.com>, 
	Ricardo Coelho <ricardocoelho@expertisesolutions.com.br>, 
	Lael Santos <lael.santos@expertisesolutions.com.br>, lwn@lwn.net, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Just letting folks know that, finally, all speakers have uploaded
their slides and/or papers;->
See:  https://netdevconf.info/0x17/pages/sessions.html

Thanks to all our speakers for the contributions!

Please take a look(especially speakers) and see if anything is missing...

cheers,
jamal

