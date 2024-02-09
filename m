Return-Path: <netdev+bounces-70592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0722184FAD5
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 18:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3965E1C26631
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 17:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4734F7603E;
	Fri,  9 Feb 2024 17:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxLLWy3C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234EE6BB2F
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 17:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498921; cv=none; b=WQ74WP5pke+lAvG+DWeh5eqdXmoDGUHbYUUcEVqZHnilD9hCEFp5Qx7HDctzVKJtGJkakSS82D4LmmR0pY+3qlAGItq92dgdqCkXk2QRr/QWBpgJ9XgyBtRtUswJRuIl1qDo+t+cSXa+uY9JyrMrCIVQHyOn5ErZtj5eTgiv/8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498921; c=relaxed/simple;
	bh=YZzrl+vOEKXdHCZgIFGqWuz7RHZQYnn0TfXOAxrg7og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXeMKIIU+F8t0qyY+3mgazqNrk+oj07H1adB9JEJhB3Hzjumxw2iaXIfkQbcnXjof6ilRgdYutDDMVf+Rhh4cZWj0s7tZ0eYUVuJTlOReAUVrH9QLCJPayLRT/za4W+2lRu+xvT7VNR9LcHhvy6biaOkxt5glLSCh/zcgAH/EG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxLLWy3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3088C433F1;
	Fri,  9 Feb 2024 17:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707498920;
	bh=YZzrl+vOEKXdHCZgIFGqWuz7RHZQYnn0TfXOAxrg7og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KxLLWy3CRy4ez/FkLfWgD3I75z/mehx09EOPhwiy47IhjJy+CmIMaxlRc918fmZxT
	 g6jFCgfz9QEaLXbdN4jZRAPAcAR6GaSLH3uLsQJJRSGiF/6hxOvq/WKnGdhZ0+Jw0y
	 17woqSinalpIhC7mBiHObt923DCBcRqQn47y69fqaOscBsE+Af/SfTV8gng6N73LDC
	 MSkg5s9277NF+T6jyTN0S36DR4rz6j5CFmEpyluUx8q7tc0bLgbuj7RUh20xOOZrx/
	 g2AzFhJM/CYC+TiUPluQ1L3SlrOcYLms8+zShM5SNZX/n4RB0AHIoEixjiuXj+wSF+
	 4xIMVfL+JT3uQ==
Date: Fri, 9 Feb 2024 17:15:16 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Naman Gulati <namangulati@google.com>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net 1/3] tcp: move tp->scaling_ratio to
 tcp_sock_read_txrx group
Message-ID: <20240209171516.GC1533412@kernel.org>
References: <20240208144323.1248887-1-edumazet@google.com>
 <20240208144323.1248887-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208144323.1248887-2-edumazet@google.com>

On Thu, Feb 08, 2024 at 02:43:21PM +0000, Eric Dumazet wrote:
> tp->scaling_ratio is a read mostly field, used in rx and tx fast paths.
> 
> Fixes: d5fed5addb2b ("tcp: reorganize tcp_sock fast path variables")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Coco Li <lixiaoyan@google.com>
> Cc: Wei Wang <weiwan@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


