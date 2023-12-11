Return-Path: <netdev+bounces-56137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7036680DF65
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 00:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12111C2146F
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12B156745;
	Mon, 11 Dec 2023 23:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="JjIdSjMj";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Odnq8u7w"
X-Original-To: netdev@vger.kernel.org
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E362BD1;
	Mon, 11 Dec 2023 15:21:58 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
	id 6543DC01F; Tue, 12 Dec 2023 00:21:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1702336917; bh=RctkjfZ/uke+J5C79Z3MVEHpAx1sc8x3waMFXiBIDT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JjIdSjMjQL1JNut9IMYjBi4vvLTZvW49XIyfzyrcGkc9fQ85zliwL6U6rxPDPqMmb
	 IXzxVpNzwNpm97PPSpYXVUZAE3dg0r0R71S9J6MmumATGg73Dqp/fygMtBgNfUjEs8
	 fgJqGNO9W20aCUKHSoh4ff0Yzkh40KTKGWPooQ9uLN91kHumfHfTt+Fzvqn8iW8mlJ
	 MOqbA1mzfpFl5jxissQRMP6m+DtPkQxKmK2ACnZRe2QUuVhcLgYDzKP+4dAJzdtU2t
	 03DbS0O0ojMCYpD3yVAwIK27C1QvWqTXHGlK2crugSrn26iKGmIyoC7GYCHJ8HVIs0
	 aFmdgfL+pCmfg==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 82DE3C009;
	Tue, 12 Dec 2023 00:21:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1702336916; bh=RctkjfZ/uke+J5C79Z3MVEHpAx1sc8x3waMFXiBIDT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Odnq8u7wg88pa7i3Cw+3L4vmH+F6XkDUyoXumbgLwUo0ceDH5mmCZKmL+hTZvzKe5
	 8bAGrTyAen597zv7HoUof6QTJhO05gha1cqezTNsi1RdU/ogMJaPdnYUZdySGfCApi
	 fK3f9zVZGAVCVWOh2f70vqExnq1KfWQFQAskQnWYbfY+Zr8pTllIw42f7iPg3qdfVI
	 Ed/m06uM6UwZdHHIIodZBe1uekJO/U4+jBw5N4h0YLJDb7WcPNhkfRjXw81x+Xj2IN
	 uijtgLj1G550fCAoVd8OgoO+5cFpjGaZHNGoIDZy0+ETkig9erb0BiOGNkLtrG9VIt
	 occqrp8xWhEuA==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 4e583e84;
	Mon, 11 Dec 2023 23:21:45 +0000 (UTC)
Date: Tue, 12 Dec 2023 08:21:30 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	v9fs@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v4] net: 9p: avoid freeing uninit memory in p9pdu_vreadf
Message-ID: <ZXeZevFb1oDvMFns@codewreck.org>
References: <20231206200913.16135-1-pchelkin@ispras.ru>
 <1808202.Umia7laAZq@silver>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1808202.Umia7laAZq@silver>

Christian Schoenebeck wrote on Thu, Dec 07, 2023 at 01:54:02PM +0100:
> I just checked whether this could create a leak, but it looks clean, so LGTM:

Right, either version look good to me.
I don't have a hard preference here, I've finished testing and just
updated the patch -- thanks for your comments & review
(and thanks Simon as well!)

-- 
Dominique Martinet | Asmadeus

