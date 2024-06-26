Return-Path: <netdev+bounces-106938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0783791834F
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 15:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA18B282245
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 13:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68699186E24;
	Wed, 26 Jun 2024 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="ENCDbQn5"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CECF18412B;
	Wed, 26 Jun 2024 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409738; cv=none; b=lCQc1a7hhfC2E9xT++6cua55BTL21/wxJkPZ5/GlnpEaPDhmd+G68oJJnTiXOjaqibjo9hMjKoBImuipqXZE8TOND/5aW3lafacfJLDprZl+yvxYoZjkHhLMViBPWV6B/cU7G2euM03ojg1FQQ2rWCuDmY7rSXIJuj7n/G1Bsys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409738; c=relaxed/simple;
	bh=yl54sanNDUWMM+AQIqqbrLuI+gS3uSjsOTBkYc4iasQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=cV0iz3DY/cTo/VKM/AWSAEihZ47sPmeVmwcWNNiu0ZRYOjKSKh33U6Ne5BWEMKJ/vGsb3VQJSiEu1BG0A4hakxW0kjMiln36HoAw0yBWPOuWG8gZpm/QofF7EGS4sQBxGnSmGgam0HBTHbuUh2WhEZItqLGqRJByaxX8EsKd2n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=ENCDbQn5; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10da:6900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 45QDmVC8786549
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 14:48:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1719409711; bh=yl54sanNDUWMM+AQIqqbrLuI+gS3uSjsOTBkYc4iasQ=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=ENCDbQn5GGHFcStjX5Wy5OtDeTD6uT5IWdAmtbaNbsvk1sT4vBMrubYcTJRiftM6N
	 /LilZ37BQvZ8jbnbpIJezoMlr1bxBWqyJFme6gpwr2hQPXZ5fKf1JlP8lWd3WfOqLs
	 SJn8yXdpi0RY4/yFlktzBJ1/ZJM2/YmeQjjb8lnA=
Received: from miraculix.mork.no ([IPv6:2a01:799:964:4b0a:9af7:269:d286:bcf0])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 45QDmVNM3646086
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 15:48:31 +0200
Received: (nullmailer pid 2317260 invoked by uid 1000);
	Wed, 26 Jun 2024 13:48:31 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Daniele Palmas <dnlplm@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH net 1/1] net: usb: qmi_wwan: add Telit FN912 compositions
Organization: m
References: <20240625102236.69539-1-dnlplm@gmail.com>
Date: Wed, 26 Jun 2024 15:48:31 +0200
In-Reply-To: <20240625102236.69539-1-dnlplm@gmail.com> (Daniele Palmas's
	message of "Tue, 25 Jun 2024 12:22:36 +0200")
Message-ID: <87h6dfak7k.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.0.3 at canardo
X-Virus-Status: Clean

Acked-by: Bj=C3=B8rn Mork <bjorn@mork.no>

