Return-Path: <netdev+bounces-217403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18178B388E0
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 19:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2EC461B86
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E8619E82A;
	Wed, 27 Aug 2025 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sarinay.com header.i=@sarinay.com header.b="rK1g6VF3"
X-Original-To: netdev@vger.kernel.org
Received: from natrix.sarinay.com (natrix.sarinay.com [159.100.251.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13E8273F9;
	Wed, 27 Aug 2025 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.251.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756316924; cv=none; b=suX3QOlu3SXK57hrPuu7Dsn7WgEp1Z/X/7Cq4BmOV9GdYgWB+0aFijP3qBfXCb5bHSje7NcW8Pih8kapWH1N+tfNHPNXP/zfl1Fv2bo4rxOlTLDFY5fqRTP0Nhw5p3hnXmCxRj6dTQcao5+kmDI7Gj0V/LoyI2ILbC/CdNhFUKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756316924; c=relaxed/simple;
	bh=MzK6hjdsHzWjAx0dhXNnuYZv03t2+HCtYmmUM0F3X1k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=muxYhCGg6uSvejWWs9JTFhUJxss9XujMf7Hd9yqQQzXtkxvFcAeS77OSMivHn64iSlNmb+nQGvRc9OzjnJyfvOTedEy1Oy+3KC+eQojJJIxr0Lw5r7G1mJXuGi/TdVOu1A1WA86MCQUJLoHBx5RZn8wcJOmaXH0RY2P+Cee+UlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sarinay.com; spf=pass smtp.mailfrom=sarinay.com; dkim=pass (2048-bit key) header.d=sarinay.com header.i=@sarinay.com header.b=rK1g6VF3; arc=none smtp.client-ip=159.100.251.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sarinay.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sarinay.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sarinay.com; s=2023;
	t=1756316914; bh=MzK6hjdsHzWjAx0dhXNnuYZv03t2+HCtYmmUM0F3X1k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=rK1g6VF3F6SHGb6Mw5MO2zxHiD+vSdYorLiUxui14xmqBfvavHfON18EOHDwH7eK4
	 2APagwjRbYXXU36tMraF4EdnCfuarLDOBZCmLe1otjpfkkWkLHGAkkbR9DY0Ip9ZzO
	 LdnD3Wr7CuB42V6fRDfZyGXiiBVUpv7UX9l4aoCHU78AwzeCplA1vkSPZsPfvRnjhr
	 6ljxad2sVMzzHfmAwHxfVagxrDanQVbTMq9zjFSw30oYx7oR/EStxUAb3/iNqrTArN
	 me+FdB04stmFNylNSWwCaYMxY/Czjc9mrMw+lauQcbfyUYbuT1Q80Me1Hd6bZk4SUz
	 +moY/6A88gVmg==
Message-ID: <518333811aeda4dc42445efd6d9cee6cc580145a.camel@sarinay.com>
Subject: Re: [PATCH net-next v2] net: nfc: nci: Turn data timeout into a
 module parameter and increase the default
From: Juraj =?UTF-8?Q?=C5=A0arinay?= <juraj@sarinay.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, mingo@kernel.org, horms@kernel.org, 
	tglx@linutronix.de
Date: Wed, 27 Aug 2025 19:48:33 +0200
In-Reply-To: <c0c14ec0-f582-4e26-bc7e-35a26a7ff1ce@kernel.org>
References: <20250825234354.855755-1-juraj@sarinay.com>
	 <c0c14ec0-f582-4e26-bc7e-35a26a7ff1ce@kernel.org>
Autocrypt: addr=juraj@sarinay.com; prefer-encrypt=mutual;
 keydata=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
 oiRvevraR4S+FMeNg+HrhPNNRy45eF4M2RQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-27 at 15:29 +0200, Krzysztof Kozlowski wrote:

> CardOS is the software running on the NFC card, right?=C2=A0

Yes it is. I may have been too specific, all I am saying is that I made
some measurements.

> If so, why would this be Linux kernel module param? Kernel runtime setup =
is really
> independent of what NFC card people will use.

I suggested a tunable timeout because I am not sure what the new
universal upper bound should be. It may depend on the NFC card one is
communicating with. I have since learned that module parameters are
strongly discouraged (within netdev at least).

> I think this should be unconditionally raised

I am fine with that, but would argue for an even more generous timeout.
Five seconds, say? One can always set a shorter SO_RCVTIMEO from user
space if needed.

Ideally, the kernel would also honor a longer SO_RCVTIMEO and treat
NCI_DATA_TIMEOUT as a default rather than a rigid limit, completely
obviating my subjective need for a parameter. I have not explored the
idea further, given that a somewhat higher value of NCI_DATA_TIMEOUT
solves most problems.

Best,
Juraj

