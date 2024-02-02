Return-Path: <netdev+bounces-68551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88BB84727B
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 16:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40CC1C20BB3
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 15:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EDC1420D2;
	Fri,  2 Feb 2024 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaqZS6Xj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADE01C33
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886102; cv=none; b=Z4lxoiSC2kRIU7l7B1Xmk67tu0oXiAV3L3T9cU2iAdFzWljMO52lvrVA3lM2uNcYW20IibR7z4SKt2cveMgd0RwOJ63BR7AyzaH2tGoqBX84fwmAz2f7C0AQzlRDrK93bhQoTh0Z44ZoD/TannMQT8QrAcHegeo3AsZ3k6HUAow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886102; c=relaxed/simple;
	bh=ThUfHn/qCbaOV9CqbKBBZ41/itfS9Qo5nHHG92u8sm0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=kcrD8YJskKleSyVerTy3ehzKJE1/ASCVYsR5TRnEe2DaM866ULNL+fotp4wEQnZHYEqhimu80CQfxJ/amX3Xsz3IbW6qrPCFdADPQkALePCDQUHIEEF/N/9lAKFpkl1fYRJnbu00MWEcluvu/v3RfTEtXxwZLORtkyQQCQih9Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaqZS6Xj; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6818aa07d81so12846386d6.0
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 07:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706886100; x=1707490900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FL9RusRT1kKSgEC1D0VCE5IsisdRYSLw6TqhWNiuGus=;
        b=LaqZS6XjJTsw1kxDhbr5L5B6VsCC5sFcGo/K0z3swXNi7xX37n7H2YxH+Nbi7KseHG
         jiX6RRR9YOeEzGdsF2qp5tg3TlzKUd98HSHRdHhfN079PMriqzZqj9XqXsqKmF1fB2D/
         sIJCiTnzQKntVpgPngjrgcaO0tCxUC+vy21iTgnfmWyVcirVThjV/bDpCLcsX+UTmUGt
         7eH0S2XCFjknLl3QUb6xQQyes0smBxK4Hhek50CKGOaL+Ox/9/pCtGdoabCzL5zgxbqS
         xw5LvCcVrCWXCZsiIIbqb5RQ/TO6WDKZeDfFS0KUsvhE8m/MzPkGu73LhG3q9cbTEPfR
         LQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706886100; x=1707490900;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FL9RusRT1kKSgEC1D0VCE5IsisdRYSLw6TqhWNiuGus=;
        b=iva8vP1Jn7XIIl+yjtnc6LuxjSIIW3V8JzC8bJ1ooB6W/d8m0fHHH980Nu5uzhAvs8
         VXRWoFgmUfgB3m0k8my9bznXNzNF1O10GPHYHnPhtsEqaSz9LT0VjCMwdBcfuaor+YWz
         kBbHbcCaEeDe1QuccFw4yM0nVdBA7d7P3Qyz4iUm4eTgFlzA5RiPhvlW65a6fSWkpben
         g70nSAT5L8XWbrSqj8KaQ2AwwdKhxq3sn5p3aAWlunPbSrSiwcTXcKHn7vl/TTBPOfeu
         7/8e6GB+UbaDc2QlwWND0noYRTnegnHvtujunI9jeCUxcY5lgzmn8dliUcBVts4lq3LT
         a1Sg==
X-Gm-Message-State: AOJu0YzcGGRqiqCpFwhnPT3Dr/ZlEBm7z49FMbi818IIVx+oI+DHU8tz
	lO0S1brZlJS9NIE7cH3ineImByjxxBXgUihShtDq+XXfio+Qqufm
X-Google-Smtp-Source: AGHT+IEcoVQdIThEcRua/rmCWI+y1WHqWPeBL+RtdmocKfHKjzxy/zCeVlAvkWgo4VcyYOz9WmPKiA==
X-Received: by 2002:ad4:4ea2:0:b0:68c:5cd0:bbc2 with SMTP id ed2-20020ad44ea2000000b0068c5cd0bbc2mr11258762qvb.26.1706886099806;
        Fri, 02 Feb 2024 07:01:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVYhGUrs76nLTF2mDWzRNtLLyYtJ+fqnbjeYlj6lXVvt1964vI1Loz6MPc8Lr9I+0cK5mg67k4WyEgSYNVnJJHvoEbLvY/28XcyxJWn8PdQc352OcSkyyNiZuwf9msapmDdI/cgRdgqUl0O8EpJATrw8TYs8zhbacJYLfq1uf+h6Hm3/LwtYQGCqBa3G9jCW4IfJrQ=
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id ff3-20020a0562140bc300b0068c80f69ce8sm857015qvb.142.2024.02.02.07.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:01:39 -0800 (PST)
Date: Fri, 02 Feb 2024 10:01:38 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <65bd03d23e6b4_2ef2a9294f3@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240202095404.183274-1-edumazet@google.com>
References: <20240202095404.183274-1-edumazet@google.com>
Subject: Re: [PATCH net] inet: read sk->sk_family once in inet_recv_error()
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
> inet_recv_error() is called without holding the socket lock.
> 
> IPv6 socket could mutate to IPv4 with IPV6_ADDRFORM
> socket option and trigger a KCSAN warning.
> 
> Fixes: f4713a3dfad0 ("net-timestamp: make tcp_recvmsg call ipv6_recv_error for AF_INET6 socks")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Willem de Bruijn <willemb@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>


