Return-Path: <netdev+bounces-224061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DB6B80622
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C7FF1C81438
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F08333A89;
	Wed, 17 Sep 2025 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIrWKclV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4C1333A92
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121145; cv=none; b=N25q9RSIK2Txy4C2ep/Uauj08DTOJPIKTpG6FDosIvLxzBZ95F/aLYyTt4RmUuAp9CxM4fGOJoJ4fgxezP5VQ6wvmzdp/ap6oear44OoVi5928+z3DgQ0vKQMafN34rfvqFHTcW6E7nHyrItqKBZb5EVCf4s1ZVa9wu9nJAWudg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121145; c=relaxed/simple;
	bh=N2f4KBTCNcMXg1vMIkARgN3+/PtVIYzfmpkctAZHxQ4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sRoB9HSl35xxOpu7sLppWAi7VkPlSC/2gK1PkFLe8EPNZKwFYF6c5VGsK2w5NwNM0jmNK+49q9rAlTGi1dHmpMLMwARpfb4EZ32Jr/Rwt3ZImDQMSMXdiCZCHQN65dY/YORopp7T51l/EGQgTB/g16eu0IciB36W6/7LC2gtTpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIrWKclV; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b7a8ceaad3so33675771cf.2
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 07:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758121142; x=1758725942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPs0x7lHCNQ3ErYVypjSTKwjfdOvYwEKRwPQgRBKhAo=;
        b=XIrWKclVed2GcS4Qbk4YRUzqbcO6/LDvlxFlSFHiAuLGMmg0C2oKnHz2RMjhb29CPb
         w9qe55hVpnCEA6YDI+oubFESV9XoFv8uCH9CmvoK3vvIExqzw+Z1bXjSSQ32M11dqt5U
         sne96CXYhvYXhPVbS6esc2nYH412idQzkMODob7VzZ/G2v9nHwvMRhAO4pnuz+4Kom+y
         uy4yiDpZuPa2Uj08OKxPNPIyVX6tBQpKG/vCeP4MMyX9T8Qe3m++uBi+Yp9Me7xZKK5G
         zOFLDhoOBJLYe+2Vi3WmWaxL+ZpGYaiNeEfrmlUtMKypMkk2IYn5XO10b0EuVwg+IuTh
         LfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758121142; x=1758725942;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pPs0x7lHCNQ3ErYVypjSTKwjfdOvYwEKRwPQgRBKhAo=;
        b=rKu568INmR6upxsSQZ6Ot/yTfLITagXw0YHVuyrqp3e8Bg3EScmOPweuCftpqVG7TD
         gJZOwp5coi6D+9ZvSbAf/MTYNfJtRlvh6KOHw9VMfAnNx22EbyqFfcjKJ5q7mDOQeKur
         DCCaiLBIsChhwcPHB/+9bGHhnTPLF5lIz1TQKCfVRlE8ORTkDjMG6PSNHMh3vIsfxx+V
         vGLjc/J2lILkZGnc8fqCpl7Hh3Dr3mvkPMTwY6MzRuFP7MSTyQtHGlGvvA1o5ZfJ+bvm
         JynIq6UBQcbje+rImEdDVieQrobOnb9aTXAdMG6eD+sMFqrl5exOrL9LsJLudIfoSQvF
         RQkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTZOFpCDMSYuDX/5AljovF+Cr8s7HDkYE3QxQuynpVOWvJUJiy/dgRADGek2dwHec0P5rtCZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwpT84neJO6kxYVEUjOQ1sPMITWaERW+6oLmwJJeHP35LJ5Xl6
	T9CDrDIxrhTL+W6ZIEZxww/woVWb23zpV1ItwhqSmy+IMcy7pBCUuH7I
X-Gm-Gg: ASbGnctWHa/+kYlKsy8L5HjspgFuZjjrgrXrA7gDgG5PhSDTbPYzfOf+SJmT+ioZZH0
	+tcs6hDY9eWVotxMXBa2fFmM0MTNUhCB7OxAD4PeSQdzEyfLofStaAo/9aL6iX+kaJxctsERjIP
	XmmySLOegrcB9E7fKntIkEMaMZsR6uQY+qRU93yx8ywyqb1uRTDW6hyr5tMmTUlAC8hWtVvdJHV
	vBJIFvInCRW2Ql1f8eeuhTmjS0wSJ9lIwliUei9ZxesZNEyBMC13OMJkGIqO6K+tSQkWMZVWkHx
	nEjyIJaV+gf6DukqJqTE/uPJZkcAF7IQgM/yEQ9sadD2ALXwqcuIPvoQC4veNlDK22Nm/oIh7U9
	VdrMSXeJcN7KlKv0Wf68nIPTmgM+XZscE4dC2KBEixmvOwljAzzWnfFtQZSO9lRGB/W8tPRMae3
	ZJBA==
X-Google-Smtp-Source: AGHT+IFLHP3ctL8Nreo+QxP0cfRsq+PCk8SShiFdYJ7nGwm9ag98uBA/5dI9uSK0dzaxBAoCDA81Qw==
X-Received: by 2002:a05:622a:4d8c:b0:4b6:2f52:5342 with SMTP id d75a77b69052e-4ba6c6b67c0mr34176791cf.79.1758121142217;
        Wed, 17 Sep 2025 07:59:02 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b639cb2102sm96467471cf.16.2025.09.17.07.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 07:59:01 -0700 (PDT)
Date: Wed, 17 Sep 2025 10:59:00 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <willemdebruijn.kernel.2f4806d8b4fd9@gmail.com>
In-Reply-To: <20250916160951.541279-2-edumazet@google.com>
References: <20250916160951.541279-1-edumazet@google.com>
 <20250916160951.541279-2-edumazet@google.com>
Subject: Re: [PATCH net-next 01/10] ipv6: make ipv6_pinfo.saddr_cache a
 boolean
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
> ipv6_pinfo.saddr_cache is either NULL or &np->saddr.
> 
> We do not need 8 bytes, a boolean is enough.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

