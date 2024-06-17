Return-Path: <netdev+bounces-104248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A01B690BC1A
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 22:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33B71C23ACD
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 20:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40D1190485;
	Mon, 17 Jun 2024 20:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BKEnu3FH"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2B318C356;
	Mon, 17 Jun 2024 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718655795; cv=none; b=ptOphIn6KDQi6dGOsBj4Srh+8s9i5vx5XHHg0HEa3j3hRX/CyC/HEqTJsuMmAhAUF4YFqHbxnDw7FVLbzWFjDU0RK6+9fsQpVAqiqKT4XlzKQlse4NomvTdPsw1y5ovI8kStk4oxUIn+Z1sqktTq4oqMsgEuH/IQD066GaTYhgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718655795; c=relaxed/simple;
	bh=wPFlEF1YxGWvnXt+UGKCZ/qmJZ8yp1ER+M+fmZUtcUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pfLI3e5vg/sjdWfosDBl6aqSZO4GE2rirbbYF5r02K/0qLD60VJ4YXPeUSLJiJPO+fpOI51l9ekA01m5Aj414M4Hh27BKxgIFqs9Y3fUfAMBfdJ3r2cd0ZdsEe14TvpVRLfcHI2zXlH3qUdTzWV+wnT+tzOw1YbekrZ0tX+9F/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BKEnu3FH; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718655757; x=1719260557; i=markus.elfring@web.de;
	bh=wPFlEF1YxGWvnXt+UGKCZ/qmJZ8yp1ER+M+fmZUtcUY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BKEnu3FH9vi2Y9qEWKLS/+d8sFWsJAp9Qj4yaQ/eSG3Teo45LtKj7bhCGTRVFpLh
	 pmgsWGVg1gTGLrAANCJEDypgL98I7rfjXhdXu16LbAzpUilmQWqnXzgWqA17tgyDC
	 RPHt3g8VTPi8pnGk8qtCsaBAgzmyIOsyPAA2yhRlt6dglBwChleFnK+gDKFlvipij
	 8Y94EjsMlqzZpD0vh5ezj6PjjBYDWiZ/J7RnNSmeMSB+s4nVgv6q4noMK7zHc2UD8
	 s2PThjGz9h2M66gh1LWndFKsv75KCQ0rLxNLWnGBQvSy14pQ7U6hZhl9YZ2BGj1on
	 KYINHNA0mgbTPRF+tQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4N98-1sTin51qH0-00uYEY; Mon, 17
 Jun 2024 22:22:37 +0200
Message-ID: <06b000c0-2ba3-4e83-8f6f-fcb8fd7d955b@web.de>
Date: Mon, 17 Jun 2024 22:22:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v20 02/13] rtase: Implement the .ndo_open function
To: Simon Horman <horms@kernel.org>, Justin Lai <justinlai0215@realtek.com>,
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Hariprasad Kelam <hkelam@marvell.com>,
 Jiri Pirko <jiri@resnulli.us>, Larry Chiu <larry.chiu@realtek.com>,
 Ping-Ke Shih <pkshih@realtek.com>, Ratheesh Kannoth <rkannoth@marvell.com>
References: <20240607084321.7254-3-justinlai0215@realtek.com>
 <1d01ece4-bf4e-4266-942c-289c032bf44d@web.de>
 <ef7c83dea1d849ad94acef81819f9430@realtek.com>
 <6b284a02-15e2-4eba-9d5f-870a8baa08e8@web.de>
 <0c57021d0bfc444ebe640aa4c5845496@realtek.com>
 <20240617185956.GY8447@kernel.org>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240617185956.GY8447@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Lc/0lPeIknXC+2mJLAHxQI9vHcnuZ5BJ2Y8Ilu2I/szlWScorLa
 F5wgk6FyprnTmEpigGddIqhEdLIcADF8yJCoN2GEvNgf6tmjLBok37UhRI0jzTSvYrAD7lv
 n1B8ARyZqiaPn7Ksy85dcWaTByCimFLbRTVqZM3zTePqREB8d97jNJ0ZZ0ovnY+VkDUNAQZ
 JVI9IkLf8OviJKDr8wEkw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QkFZKWs7BT4=;G8PB0RBsiNIwrWBnokHcU9Z/Ygs
 +8l5bJw/wQq1l+S2cs0uOH99dXbo1WOSnSCBxQeUkG0w8gZMoihEoaqt0tqGT/vqe+yvs8EH1
 O6ysLv3slZUR0ynmiKrwOQ6P5KDtAl8lzhMq6sZPFrvlU85OkLIpgrnas9APqjq/dGi9merPb
 S0mBjoDmt5Nxo9WrcWE7rMAcYQAyIuRD7XwMbHIOqCW7PUCbRfxPD0C03XbpjrWtj7/pJXEA/
 Qwi5XB+rhP1/lv4qkvpQnkPbfXXXQbMZ4OQDmh6JlzNJkjYMParjoMKxEvx91jJRvzk2KQaq8
 LH7l33/3ONTMfmD9ij4S8kOzpkjU4EdiCax4qCw4wcdfzy875gbitgqFZecV+TJkgZ2PYCU2Z
 b0O8PP230kxJZeRELjneElpFQ5ETYBkOHYHdtlkw+8PSwoX8Wv5y+VZ0AlIn40jiB+sAVyAoK
 4x/+2y3N2ZrRJ/hXknE/cw1YrMfJVJtw4ijRCQBuGrkwbNXnNPuF2Mm2fvxHw7G+zHnG0/GFx
 GYRaNLYutU215ZGnQm2wyrzeUaQNgBR6axg8wP9TfpnVnAFi8STU29vnfBZAuUCTy4OFlwjbk
 fOL1EBv6ygW47lnpOsow64HpogyExOflz0Jqha8J+pd4dlCwl2IVNHMkFcr9ItbeCuydvjHPZ
 8Suibm424jdiwxoDMKtQN+LR/viQxebho9bJc/s5kShdPuqwrbbu9sV2h/5D1CcwHxEHiIvrf
 nmc66CJ/FAftIEtKmUvaPN5pxbplayAwN69Ajd1fup9XfjVUir3lGeXv7KFSj3DzL1GTfDYWM
 PzVAqGgFXLSNQLbzIW9C3Ohh1LvHNZ8FInOpjM+/dg/lM=

> I would also suggest reading Markus's advice with due care,
> as it is not always aligned with best practice for Networking code.

I dare to propose further collateral evolution according to available programming interfaces.

Regards,
Markus

