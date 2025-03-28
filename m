Return-Path: <netdev+bounces-178148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 222A7A74EBE
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 17:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60403B5499
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 16:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604031DD0D5;
	Fri, 28 Mar 2025 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKiGt76z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0DC1DB55D
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181180; cv=none; b=iSvKBCDXMmsg6hvbL7kQY5H41pgsOP94xpTkZMuRDw14UnfeVuh1Apcvgc7886erP30ZJZWOFe44WHXll8WN+NW5L3CQOm3BdaCLphy9w62wvji4Kqpu7ekDS7XY1bq1dZkOTjpmkeY8YeHYahjDeR/rsHU0D0q/d8k9ZA50b44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181180; c=relaxed/simple;
	bh=vzvio6ovr7Iz1GQ3HS2YKO3+e9P4dpWRcYZONg2Q8Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTXzWvQVkKkA5TYtttAbYCxJtihMkGjIGLF1sRyZd/Y42ZlQ+o3w5+PaDJEGIZCkcFj9uy2RBJHDFRbvU4eF3NUxikfCLzaqD6eP49Gu9Od0b35Eq8brqb4XhhMNhrurk2+LiW8Mmqc3E4vxcBe7AOvVonTfRLhEkgvq0m1Y5Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKiGt76z; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff784dc055so4059607a91.1
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 09:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743181178; x=1743785978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ocHVTrCamovrJRcY0a74hjSp1PruFYlZ1n8m34ifyyU=;
        b=hKiGt76zQlY4Bz0Jx4eoiJYPQseE8xILi1nKM0xrl0krEmfVvkyX+jsBLKEQdV2Kfr
         QO1m489xEIiN7m7m22Gqq0F6nSM3Zr/dGZSj5hwQkQqadaKNKIUYfbkgCQjGBPVj36iy
         TMuMS7o1NFe6DWQ/awxURWOZtlIKOYncoVdMT45pdAWCofz+d6JN6gOQHxmjZY+WzyY2
         pqWkCabjhjQh0JIyiNmy31J3n0ZmEY+uN0jY+oLU0l98yormSBUEqKa0dYJVHDr8CSPO
         V5knFYOOjabUkU/IW7c/exp5cALKgpjeMijCCbAf/o4yeUDrpshFyi4Qyq9O6jZtdRC5
         hXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743181178; x=1743785978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocHVTrCamovrJRcY0a74hjSp1PruFYlZ1n8m34ifyyU=;
        b=RE7KflY/+kmM++uspCQ7UpFkeenlhnTa0FTr0VHkURBnrU1pqkGxYptUW1kql/K3Gr
         rcLrDk3zI93oLYZW3JZJip0gUWuVIQgWWuOV1gYq4a4EHyFisqhra+NrT1Nrmf78E5+x
         W++ZcivNrwfOUsmVT7BNr1YWAZW5bKG+RoJEuBgZhjH163J8o//IDK1E9oM9nLQ7qXvF
         0Z1GSNldL7TBzBB7SIF2+OTC3QSPYcd2+z3Gkq2aYMg5JwYSXDx0Qx20+VY1hCu50g6P
         y3ezzwwGx99L3v6TMd9EtEkj6AuXUuTqAWywpSuGR9S5NUXsTCZBo54RxeA0Dwwcscfs
         npvg==
X-Forwarded-Encrypted: i=1; AJvYcCWiU5AfbA/qHxqBmOdFIe3Hus97xzDYPD3kGYX3G8pxJJXsMflVwQ81LA0hdrm+yCxP3tsDjYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YysCwtvCamhRiu7Uywa9L+ZSdpJntISUnP7iuUljX/ZK6YHTlnl
	dDyVaozisHihf7buR7DOuQbq7yuCKP7D0mrIaC3rBoycI+KtbTGbB2SDtmoUHg==
X-Gm-Gg: ASbGncu20xxszIfdzr8SoPmIPe7BmtQetPCojxMm5WHS+8Hj4eE5IzO2YdQ2xBH74Zq
	1Ark8yXlqZWz4dJbjB28VxILLE9EpZ0jUT27WcoP5pwff1Ak0vBqgoW5mG5YRs/dpxahkxP7hmL
	G/QTA0n2NifYG7cRspyrXoeXQYFUaYVGZGquH12GnMwNhLTOOg5t2b8NfAEqY9vbJRuxB6E3I7Z
	Qo+OkqJl+cxlgMopgAkjp7tLmyVEqHPfXmSVinILCfI4OhwEQvNf0gThRdnbluqdZLLB5naToFn
	1hjUtia4lA/gWLYoJX3bMSUjcynsQGL9mwBrPJlOKx/D
X-Google-Smtp-Source: AGHT+IHhkQEzgHtuEB9Bv8dN7eeDi34cLgZEuYqyF7qT8CIdRb1gmF+vwe3y0ClCQ9j4bNnk2JL8hA==
X-Received: by 2002:a17:90b:2641:b0:2ee:90a1:5d42 with SMTP id 98e67ed59e1d1-30531e8873emr100358a91.0.1743181177941;
        Fri, 28 Mar 2025 09:59:37 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291f1cfec1sm20561045ad.118.2025.03.28.09.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 09:59:37 -0700 (PDT)
Date: Fri, 28 Mar 2025 09:59:36 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	jeroendb@google.com, hramamurthy@google.com,
	pkaligineedi@google.com, willemb@google.com, shailend@google.com,
	joshwash@google.com, sdf@fomichev.me
Subject: Re: [PATCH net] eth: gve: add missing netdev locks on reset and
 shutdown paths
Message-ID: <Z-bVeHQpkvzPrb0_@mini-arch>
References: <20250328164742.1268069-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250328164742.1268069-1-kuba@kernel.org>

On 03/28, Jakub Kicinski wrote:
> All the misc entry points end up calling into either gve_open()
> or gve_close(), they take rtnl_lock today but since the recent
> instance locking changes should also take the instance lock.
> 
> Found by code inspection and untested.
> 
> Fixes: cae03e5bdd9e ("net: hold netdev instance lock during queue operations")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

