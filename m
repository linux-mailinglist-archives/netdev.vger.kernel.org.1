Return-Path: <netdev+bounces-178928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 718A2A7992D
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 02:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72CEC1893BC5
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 00:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E34A7FD;
	Thu,  3 Apr 2025 00:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBswYrIj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E9D163
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 00:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743638736; cv=none; b=L96BS/8+LgZZWUhS0g9w3yeDiImzk2Gv0UTYKn9WLJTj3qV+KifhrqkY0Vl6ia8A9Az9lMJHXixTk6EoHEO2XeGs20VzOe4w5B8H4vFiustd1Qq97DzruxBGvTM93EtneFpU6k2H/+aVFy6TvIYrV340Nw+PNTSZsDHNAVegFx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743638736; c=relaxed/simple;
	bh=Z45QaKRrNKwBqRmjcdJbh9gpamNDSGLyRbj/AA+TjoU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hN45o3GzcZOv2ir3OKX2QXNG2VKi7h8ItxxmYEkoS8XvVPPcxQnHoGnTvpQISp5C4twkKCIjY36CiTBlSesIgC8DYCB1EcbuhJLPlSX1GPzGHLd+kcBkzGIzN+GrrpXnpgGAyNp9RmGpxCZ/9cTO7vL1nuyR6EGWNM0aZM1IRLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBswYrIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D46C4CEDD;
	Thu,  3 Apr 2025 00:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743638735;
	bh=Z45QaKRrNKwBqRmjcdJbh9gpamNDSGLyRbj/AA+TjoU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sBswYrIjNaSTWPla/UI0oPHHQ3tC2gyfxw7IThdmrVf4+h4AGkww+9d8yzX+q1dFm
	 SxVm021vLhWu0pPBw528UG3hNBci/0Ydjmevo9m+QzYwQMaG9tvoTMkYd49S1agFD5
	 wGtkdxSfTJYju465xbohihtOOLoVpPgMYRNhDI8nUbO/rDS04aftbZ/LgWMqacinaU
	 Zq7fhGYwnA1Rd+8cGH7D8d2z5R3gUda30MEzYB38E46LGvC1PyzJ3wh1euoWXIz4lM
	 nVfEm04kU7LIJx4JK1WkFUuE1uCAKoozgs2qCYLjHdW0+NE5dgY1jqAQa9aU37or6G
	 ghkvg/+5oV/pg==
Date: Wed, 2 Apr 2025 17:05:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net v5 00/11] net: hold instance lock during
 NETDEV_UP/REGISTER
Message-ID: <20250402170534.40193201@kernel.org>
In-Reply-To: <20250401163452.622454-1-sdf@fomichev.me>
References: <20250401163452.622454-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Apr 2025 09:34:41 -0700 Stanislav Fomichev wrote:
> Jakub Kicinski (3):
>   net: designate XSK pool pointers in queues as "ops protected"
>   netdev: add "ops compat locking" helpers
>   netdev: don't hold rtnl_lock over nl queue info get when possible

If there's a v6 let's drop these, we'll queue them for net-next.

