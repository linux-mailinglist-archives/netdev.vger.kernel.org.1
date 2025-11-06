Return-Path: <netdev+bounces-236104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D85C387B7
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 01:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B083A6B8D
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 00:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D3510957;
	Thu,  6 Nov 2025 00:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfGWJ/zQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957BF20ED
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 00:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762388928; cv=none; b=Ze8BcZ+T9LQ93BhfeXwOH+scO/w0O4rXoBGY/KKKOOLvltU2JP0gEG6SpgdH03c2KrUdlnePyjJ3xfda72TU+/KV3MJLYR/8G6J5xap1c2pM6XQ0vrRJQvIGb4tqt/5gbYtdk9TPNF/nXs1EkkgqKtYpB9043q/2oKAE0XnmA+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762388928; c=relaxed/simple;
	bh=l2gVzr7ua9gwgbl7Vz7D9mJjNQJV8+w+PIZQo2MLJlM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBD1ZzhsoCZtFV/i3FOTYnWIIWxGygoI832oE3w19l5CN4AmSIDa8YGg6J483Jt5Bs2Je0c5p7fCdCSHE5B9gdrWFQy9IdfQKf+8XilsVK4+qWRVrQtMhIiwoQlhnkqZ3jqjiS+1oqO67W/XU5x8xC/Zem3hSTrtOYaOi7Dc6Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfGWJ/zQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D115EC4CEF5;
	Thu,  6 Nov 2025 00:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762388927;
	bh=l2gVzr7ua9gwgbl7Vz7D9mJjNQJV8+w+PIZQo2MLJlM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dfGWJ/zQYcIv6FXmMa5XHigsI6uK8RODBtIoQhgLOUqUtWAER4HVOWo57uSXVcBHg
	 5MmsEDAkA2MZRKrlrk8ccVL7fz45uUYJ6pPExP88IjmKeVDiSDRiWMGyWUIv5F1yBb
	 SL9Y438Jd25hEdNWz7BEie8DZmeVbwoQJ6doKrSZoDa9snu6oKU8jzY9TT0ElQg33W
	 EzmssjwnUahwlHIsLod42JBBqPa9sjF5QJEH+J/F8xwYvSG9Y408ejYSQY9dmysohj
	 zPXvc0Zi7XEnMCmJUXZzyKq2n2ZucHIWcbVa3AkPRkiyWL9uvfWYCfDXX4z9w242Lx
	 fBmoRqSzzPHPw==
Date: Wed, 5 Nov 2025 16:28:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: airoha: Reorganize airoha_queue
 struct
Message-ID: <20251105162846.53acd791@kernel.org>
In-Reply-To: <aQsCYoS-cvkUjrMv@lore-desk>
References: <20251103-airoha-tx-linked-list-v1-0-baa07982cc30@kernel.org>
	<20251103-airoha-tx-linked-list-v1-2-baa07982cc30@kernel.org>
	<20251104183200.41b4b853@kernel.org>
	<aQsCYoS-cvkUjrMv@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Nov 2025 08:53:06 +0100 Lorenzo Bianconi wrote:
> > On Mon, 03 Nov 2025 11:27:56 +0100 Lorenzo Bianconi wrote:  
> > > Do not allocate memory for rx-only fields for hw tx queues and for tx-only
> > > fields for hw rx queues.  
> > 
> > Could you share more details (pahole)
> > Given that napi_struct is in the same struct, 20B is probably not going
> > to make much difference?  
> 
> I agree the difference is not huge, I added this patch mainly for code
> readability. If you prefer I can drop the patch, I do not have a strong
> opinion about it. What do you think?

I would not do it but your call.. Perhaps staring at data structures
in crash dumps w/ drgn made me overly cautions of unnecessary overlap.

