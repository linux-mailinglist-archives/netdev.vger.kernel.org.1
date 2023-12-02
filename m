Return-Path: <netdev+bounces-53277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704E6801E2A
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 20:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29CD2280D91
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 19:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F187919453;
	Sat,  2 Dec 2023 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="BNEneLrD"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [IPv6:2a01:4f9:c010:a439::d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EEA119;
	Sat,  2 Dec 2023 11:12:19 -0800 (PST)
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10da:6900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 3B2JBO88880565
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sat, 2 Dec 2023 19:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1701544278; bh=DVj6YU5qtsVR8CtNxuUON4OVY9fj7B5VUSDFcJFPxsc=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=BNEneLrD5oxC5cNuSB4I+lKiQPEamtsH0h7+LndKpz0Dy28OUzdJv4/2dPQGO+AYl
	 PtF5zZe9JUNOJx8JzhRDKR4ef2S6keVBNutDdBDpJM7+YWJlAp90YxZZWservazW4i
	 0uZ9YMwYR4atd7kPJuTpbjBr+b26/yTV/+TiUhLY=
Received: from miraculix.mork.no ([IPv6:2a01:799:10da:690a:d43d:737:5289:b66f])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 3B2JBH5A3964449
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sat, 2 Dec 2023 20:11:17 +0100
Received: (nullmailer pid 3179962 invoked by uid 1000);
	Sat, 02 Dec 2023 19:11:17 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Douglas Anderson <dianders@chromium.org>
Cc: linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Grant Grundler <grundler@chromium.org>,
        Hayes Wang <hayeswang@realtek.com>, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
        Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] usb: core: Allow subclassed USB drivers to
 override usb_choose_configuration()
Organization: m
References: <20231201183113.343256-1-dianders@chromium.org>
	<20231201102946.v2.2.Iade5fa31997f1a0ca3e1dec0591633b02471df12@changeid>
Date: Sat, 02 Dec 2023 20:11:17 +0100
In-Reply-To: <20231201102946.v2.2.Iade5fa31997f1a0ca3e1dec0591633b02471df12@changeid>
	(Douglas Anderson's message of "Fri, 1 Dec 2023 10:29:51 -0800")
Message-ID: <87wmtw2ze2.fsf@miraculix.mork.no>
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

Douglas Anderson <dianders@chromium.org> writes:

> The r8152 driver tried to make things work by implementing a USB
> generic_subclass driver and then overriding the normal config
> selection after it happened. This is less than ideal and also caused
> breakage if someone deauthorized and re-authorized the USB device
> because the USB core ended up going back to it's default logic for
> choosing the best config. I made an attempt to fix this [1] but it was
> a bit ugly.
>
> Let's do this better and allow USB generic_subclass drivers to
> override usb_choose_configuration().
>
> [1] https://lore.kernel.org/r/20231130154337.1.Ie00e07f07f87149c9ce0b27ae=
4e26991d307e14b@changeid
>
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Brilliant!  Thanks for doing this.  It is obviously what I should have
done in the first place if I had been smart enough.


Bj=C3=B8rn

