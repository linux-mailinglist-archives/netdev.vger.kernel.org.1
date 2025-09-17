Return-Path: <netdev+bounces-224089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14962B809D1
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1A2172776
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6821C309EF4;
	Wed, 17 Sep 2025 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfpMxRZY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442AC29ACFC
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123373; cv=none; b=nqkWX1ifupI0CR4V5XciFUCHThlrVY8eqaNk81/KLYKhOJmmvICz+UdPvb2LEGNHqm+sliGHkH/Hd5gIoxABa2qmr4Dvr9W9IkEkV9bOCMpfwS1G1vfa/m9qS7Zqs8zTl/2V4+z5D+a1Msg/ImtlY/rfdQ/beKNtDuXrYwo/91M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123373; c=relaxed/simple;
	bh=GkN+/4KIC6CPpsUlg169vcZi4r6sXMiSBbuheLuFQdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LyPAnc6Ou6ANJiszaOJDIVXimeUiFMSrsNe/Y0/SqTMj9Z8dfSuakALFhZfNpA3CxkyL7uhFQVW3jVoP9kc+Ya0DwFOi+BU3NhpiK9IpWa3IwiE/7uKXy9p5k0FFP5/Tn3IBtNCYbxcKziO+klme6iCGwe1vMrpmum4UFuddArU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfpMxRZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDF7C4CEE7;
	Wed, 17 Sep 2025 15:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758123371;
	bh=GkN+/4KIC6CPpsUlg169vcZi4r6sXMiSBbuheLuFQdg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LfpMxRZYKYpxRAlRF3/dWN3D930dCNuJi5b8Q/CjyWlIUqrXFIhpDcbCQUV+W1Fo/
	 a57DzpG9DLks5c/XlmXhwHxv99NMr2dqeu51exgGZNxpVZhXZcO/2WVS8b7IjHdu9H
	 LSQOXfxZ+kIIGP3zuFrt3mPEnOxf9975Hx8BhOfL8YGHU8+hl1uDc3Hcr0vOTCaUSH
	 gHMKT1fR1XFW8P95iNmLZT58kgYSogrym0QFEJmNZk6IdLiZQTm5IZtr+8MSxh95d6
	 aj7nYVv+LTtkAru78T800/f5KK6HYSF3G0Fxyjsbr2t5+3wBr3O4FqnlZi1Hb+VCLe
	 uyoMNlXaai9vw==
Message-ID: <35f13da6-4822-4044-83f7-dfdca0179627@kernel.org>
Date: Wed, 17 Sep 2025 09:36:10 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/10] ipv6: reorganise struct ipv6_pinfo
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20250916160951.541279-1-edumazet@google.com>
 <20250916160951.541279-5-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250916160951.541279-5-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/25 10:09 AM, Eric Dumazet wrote:
> Move fields used in tx fast path at the beginning of the structure,
> and seldom used ones at the end.
> 
> Note that rxopt is also in the first cache line.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/ipv6.h | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



