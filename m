Return-Path: <netdev+bounces-85416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B2389AB46
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 16:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23CF281582
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 14:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C71376E0;
	Sat,  6 Apr 2024 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdjkBhQ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1F636120
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 14:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712412471; cv=none; b=k4SwmM+lZAnqPBwJI3NFUnqfoEosR4MMYpG9gC6ehwcPdVIF5sP26HVflV/WgbI8N5Is4PANKL5uJaB/3Krylp4jUCOebwgED0lc3gqVDfYAfPM7pYCi9qFa13x1AEBN6Ne1rzXJ2uZeD4sHxWe9Hj2tzrnf91WlWUQnfMO3cpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712412471; c=relaxed/simple;
	bh=vTu8ynjvbqT7hKf43CpGpUyJAVQMCSSWuQOXjNd26Z8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=QFgQlwZFg0y4U1wC90RF1QaTujL+ldP46Wr58SHzF2H2gnetqMBv+/U7Kj4LPzO7wZG174MVd1VYA6fhbxNSSX47d6uwyyW7aDZFx62POiu4evxP8/wGERoXlPzvvknpRMUHmHHHu9Rep1yjWgGnYcQBjST1MQ2zERg0vvBr6GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdjkBhQ7; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6992f97ec8eso18758646d6.3
        for <netdev@vger.kernel.org>; Sat, 06 Apr 2024 07:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712412469; x=1713017269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7qZdfgYqcfCxCVyJ4WnesTq+IsTCkbmkka9C3rPW0Q=;
        b=QdjkBhQ7OFtE6TXf4R1Lv4IslMqG6tipch67jShso/8/vtjNIsBXeeeFyw9qyl/qtc
         o/XmHAjr5b2dUS2Th3M6R5gZVerESujt5St3ywH/ZfpDThLPWWJLM7m5tVGKslIFiyTk
         zXDY4pQu1m9oYm1px9pkfkypLFAkoeGGPBlRtbCHMuiHLCTY7d07XszFeJp09kELlVyS
         bo0ymOzWAYZRwic2fC/sG3nyaRa8Jd1T95ckW9qjzh/2sEPEb7dFxoNpMWCXeef6nvj7
         Lb4AsUjzrL+JFB+a9JDv1CviWvSYyB38WfYFe0jU/leeJ5cZ6ApPIKJCqtjy01HSiujR
         qwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712412469; x=1713017269;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p7qZdfgYqcfCxCVyJ4WnesTq+IsTCkbmkka9C3rPW0Q=;
        b=JAGMjOynblZrBvDgMIEI9fyDARJL8sUsCQkhQA3TBLgpLsEbFWFfa/nFm5FPLZs/YW
         FCfRWhBOYToLhFOc7braNTQoKfKSlSAVxiXO8UL47H4Wr7gpkoLTK/kGIlAFh9mrWnrx
         dF6tFQ0Id7grPxlPV/ShC1gOTjovkn4Fmw2Cv34w/BeYm4MBkt63c1LgidUH2OOUW+en
         PUqZaE9oii4dAn50MQBKZbBGGPO93lQ8RN6++aLIWxWOgcm0EcykgSdTHYoIurO+pPiw
         2dSAAdN9u6QL0QfdMNudTpGcQ0Y0QUdulOIMb00Hf6pE5Txx0fTTItQlhJZtoMr3fwAz
         CuOw==
X-Gm-Message-State: AOJu0YycWokexfOSacE3Vc16NwyciDR10wI0WeYQ5IRdbzuOsupkm+Go
	yGeFke709+raGlt72nDl8Ifx/X+w2mVyErozCz94wfmwM2Rxdkx6
X-Google-Smtp-Source: AGHT+IFuwX2F0g2/eyVIQLEf8RmccqVh1c67Eix2KovhNtopilO8aoDBoD2cRFlhAucCGFdlupr0AQ==
X-Received: by 2002:ad4:5e8b:0:b0:699:28ad:8c3f with SMTP id jl11-20020ad45e8b000000b0069928ad8c3fmr4661074qvb.58.1712412469326;
        Sat, 06 Apr 2024 07:07:49 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id pr6-20020a056214140600b006986d9c6b6asm1459018qvb.112.2024.04.06.07.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 07:07:47 -0700 (PDT)
Date: Sat, 06 Apr 2024 10:07:47 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>, 
 syzbot <syzkaller@googlegroups.com>, 
 Kees Cook <keescook@chromium.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <66115733b397a_16bd4c29423@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240405114939.188821-1-edumazet@google.com>
References: <20240405114939.188821-1-edumazet@google.com>
Subject: Re: [PATCH net-next] af_packet: avoid a false positive warning in
 packet_setsockopt()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> Although the code is correct, the following line
> 
> 	copy_from_sockptr(&req_u.req, optval, len));
> 
> triggers this warning :
> 
> memcpy: detected field-spanning write (size 28) of single field "dst" at include/linux/sockptr.h:49 (size 16)
> 
> Refactor the code to be more explicit.
> 
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

