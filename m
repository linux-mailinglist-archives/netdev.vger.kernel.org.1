Return-Path: <netdev+bounces-131694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA49B98F46B
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60EA51F2255B
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247B11A08C1;
	Thu,  3 Oct 2024 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T492WNzi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2BC1547E2
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974067; cv=none; b=bIJwcgJYzqx2bmrQpkgXfJ70LlTkOQU931uMsAsyJI9SBOBPL4AKvEmAEUkrQThrwBlsnunB7xHtYQTKAoW8rhgA0rVBiiY8fCKNnV41MEyix3iv6/HyWJl9Zzyqb18AyRz3IlQOleY1FXjtCc0PXj+MdcF8AkMg6/m/i/OhdSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974067; c=relaxed/simple;
	bh=b2SCrS4ZVKIENrC/MJyXYVYMYsivihfD136hFqrS0tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tI2XjZ2klYgZxr+lBWnKni5HoZVQnA8pXACi2dyT1MCWLHmfadwHnRjJ0RT0K+w9Lp5ZrBSNHpLELvKpQKp2WP05Mx2YKHw55CqD6pX6Ny/SZuwmSgwiqKpn+KMTk1KTcrhdTeA/EEjCa9syi4B+0rDWv/v2+rWxXDBA2QCsdoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T492WNzi; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso775669a12.2
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 09:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727974065; x=1728578865; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=53HnY3NGxUioIg/Q9dk7tVIva0jy9Mx8IhfVil207DQ=;
        b=T492WNziz9Xw7zg0k6lUWyRigk2Ssj7l3o1SHjhY+fqthm+8HKDJKmULYLD6j6a72K
         X4PWX+jD2FtKsCNoxaTHzoWa5ubJQgoVcICdNwzw/PnmigPc14ZmAuZ1V6TA9/Y0f+4z
         EjPhXa9dIDvpZ1hcIMdQiKYFpV1ey+yHw7ypC8LpkCEyY9J54rDOOLjP7if/DOoLpk7U
         qro358f9OkaVxQ7SpHzoijm0AsnzZUjDjKOEub+rNgteK0vJoSoA2BdmbidVKIpNiucn
         FtF2/KD4/WXoFiZXonyu+iNr6kD43FsFd4cb+9CypYFGC1XJ+Jm3kkh23gEZTN1pQ7fk
         DI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727974065; x=1728578865;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=53HnY3NGxUioIg/Q9dk7tVIva0jy9Mx8IhfVil207DQ=;
        b=ZRnSG+oSWNQ9sjOc0Q5Gv7/CFmHidGdt+S0p3C9tMEel2HcKw00f1On7tMuxM3xb5w
         nkI6fgaORR7/CaS//gl6jT9b0CAz3EfvW6rRCDf3pgysydetZAfogu0gwxnQcA3d1fuo
         /2InJJUAZPu/0DFksM0Lu7lGIKm2wGHFqu4Bnj3cQwi1G8C/W/cMqG5TozTw8YimBBUS
         Vj3CnXCUpq9xqgFBp325wEyBODe2MVTQGYeUVatMTfZMWhKMX8YqFJFuUuZyLPm5ErnH
         tJwHHG91fQE0fZyLo25LlXebxKrP0SeHESvYrrjFmjSLkoOW5gChPbttm9XD+peMDH3w
         Od8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzHkW1sYAS97Dk8z9FgrlKTKaVLa1jTK+LXAqxsbt7aFnE/7RtskUo5rlYWh71M4jqdQmZztY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVZqDwqwqGDswD8KrWuN53fXxDW7+GhNZiXeD/lNbq+yz0bjTN
	hOyFUM4ZN/sAkRFHcGwNq+nc/2tfGCDBr6UaoO8d0IEQOK5H9Ks=
X-Google-Smtp-Source: AGHT+IGPKjlC7Io2hF+2NPpuHCkJ5dnM7CI2R4hPHX1BklR+32CusQ5okizpcpUsVUjxfJCzrv3aVw==
X-Received: by 2002:a05:6a20:d04f:b0:1cf:6d67:c078 with SMTP id adf61e73a8af0-1d5f2419386mr10655792637.42.1727974065088;
        Thu, 03 Oct 2024 09:47:45 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9def778sm1565370b3a.157.2024.10.03.09.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 09:47:44 -0700 (PDT)
Date: Thu, 3 Oct 2024 09:47:44 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2 06/12] selftests: ncdevmem: Switch to AF_INET6
Message-ID: <Zv7KsD3L1AicrjRJ@mini-arch>
References: <20240930171753.2572922-1-sdf@fomichev.me>
 <20240930171753.2572922-7-sdf@fomichev.me>
 <CAHS8izP-Dtvjgq009iXSpijsePb6VOF-52dj=U+r4KjxikHeow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izP-Dtvjgq009iXSpijsePb6VOF-52dj=U+r4KjxikHeow@mail.gmail.com>

On 10/03, Mina Almasry wrote:
> On Mon, Sep 30, 2024 at 10:18 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > Use dualstack socket to support both v4 and v6. v4-mapped-v6 address
> > can be used to do v4.
> >
> 
> The network on test machines I can run ncdevmem on are ipv4 only, and
> ipv6 support is not possible for my test setup at all. Probably a mega
> noob question, but are these changes going to regress such networks?
> Or does the dualstack support handle ipv4 networks seamlessly?
> 
> If such regression is there, maybe we can add a -6 flag that enables
> ipv6 support similar to how other binaries like nc do it?

As long as your kernel is compiled with IPv6 (which all kernel in the
past 10+ years do) and you don't toggle net.ipv6.bindv6only sysctl to 1
(which defaults to 0 and afaik, none of the distros change it to 1),
AF_INET6 should properly support both v4 and v6 even if you don't have any
v6 environment setup.

