Return-Path: <netdev+bounces-129041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6695197D17A
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 09:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A092838DC
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 07:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07B83BB50;
	Fri, 20 Sep 2024 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="SApjxW/C"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB4E41C72;
	Fri, 20 Sep 2024 07:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726815950; cv=none; b=FVrnN1MTpgOt+TBFNwEb45Iks02ikGrlvkKwYIVcv9GANVitaCdGqReNdvX7vNRoj+Ow/ZB0yNCqoR008WPYfigupkcXa3jV0Pi2oEfIxJDKOGcJ6bE9sfiI/F3TqIxakyYRsy1SX+QUnCScV4p93+r1exdREeMALzsMdXI1PDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726815950; c=relaxed/simple;
	bh=MV/wpg0Bwi6atxzF0D3C6K0NvrRxaGQGgCsav+39h1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOMRux3MQqkQruyh/tTjGhM7YJUeRGxURle2SxiFieoYeoAsNl4TjuwJTQe7vc/Jo2qGqN7g2FgYGshhiasSMEI9MhTMV6NzKlBAmix1euitQZsc39gIP9ysoKKyZqrcO8KElHoODnpLVb4xDO9gvnB92KBlWyG2CTStDtitgzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=SApjxW/C; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726815914; x=1727420714; i=markus.elfring@web.de;
	bh=IxTvS8Re1mH+yLe3me+r4ZHkYxfcUhZvllapA26y+nk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SApjxW/Cz9i3W3OXAasOVa6gJalKbDJTGX1wEclbCJTJKsAGjVQfrklparT7RF4F
	 /9l1twIGMgV1QRDQvGtGfIGoOPWruGFBJqI+xNvztCRsCvRRaWb4h/UJDezOHXMvn
	 F4U7q8Wotxy2VGgpkFvh0EdUe8yICtWJRcreB7LwifJTZieckRa6Twt+YX0Rbl7qL
	 edTf5eZPurIP/G0CTYFEf0Vvm5j4Xik/ouF7aMuVwjqh1yNXvhkl9qOiPqBlo2NPB
	 5N5JUCeFMeyXmVi+OKtSzHLwjvUGU/e8j5bJOoRRnLIIdxEHUqjM6P8jttkForP/c
	 R54InfEhpPuuod1lrw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N62ua-1ruMR00XQe-00shO0; Fri, 20
 Sep 2024 09:05:14 +0200
Message-ID: <d9ee8571-208a-45cb-ad51-61926ce23d62@web.de>
Date: Fri, 20 Sep 2024 09:05:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ice: Use common error handling code in two functions
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
References: <f3a2dbaf-a280-40c8-bacf-b4f0c9b0b7fe@web.de>
 <58d38533-bccd-4e0e-8c7a-4f7a122ce0d1@intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <58d38533-bccd-4e0e-8c7a-4f7a122ce0d1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:okDhtZGdxOeK6rH3CHh40dnLehZXd0mSL2Q2FsgR28JsAvdHXvT
 HomrVNaQ06MtYvCmmHSBEW2YCS4yu1BfWbWbBV9deckg/VQ1utE8seNT5rOb859jETZjMtb
 ekuuL/ifwq49XNI9twz2QjAOwTTLrldZFa0fuUmfa0FhUo5YnGgulnEAET3Afiqk5CTug4c
 1mInlO/A4x2K1CVD6cZYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6yrI3HDK5U0=;RIpq8Kdfqk0jdX1PIKjCnlVDPSF
 9V5y7/9DTAVbAW8DUUE+IVMXzcDKKvsZR1EUWf4D1tbnAQ5GJbykO8RSY0Yc+vQcgKNXILIxT
 oOHuniAavuCd/BV9BwMB/f83ZV8JyxCRPPk4Ve/MGVYAu7r6B5ASpJJVKWAVUNb7S8ir/nn0t
 kima4eWn1RazZCvGizut7pPmnbt800FK2O1VcMm8CoBLUL8mTWcTjFENokpwU+dtjGxYzvFec
 K3sKUALB02GjoMzBQ9hWfmmRUCXfqH+kQeCbG7xwhGXpz73U9FHwZPblX15k+p++BxujaYcTW
 GgMgxytxJ2ytooiXN020cTBsHZ40KMvTSYaLY9LzjldZuV1OFS5pYH9PXMnCD2l2vLxRUx6PL
 tPRH8XQWqgKPSaIQtq6YEfyYJJxwhePYU+vHE0XB0rW9f3kEZ5gr9ZaiOGY2rZkQFBh4R2nXU
 htCixzc4z3C/WCnaRnkUfrkF6R+imW5ioRAyD/nHkDAziJDek8LGejymq5wbYOyKuL3vTQPMx
 riwWnwckLeegcO9/SK8B4itus1Jats0HHx6XiDfIfNx5DL0fLgLIb1f4JLlpSaLrBRqWYFw35
 Mik40Nmh4t1FcnFhb3KBETRt4OAzQhBuVhDRh4GgFRExE13ZKWFyvlC10YYd8hgxpxo1HQc+9
 weEyY9vHBoE/4/e4y7Ep2+Z3J2TaUpY04KZEUsv0zP45bfEBepJIpnQgM3t2dKgwdFbWxAg7q
 gEA74pKDHe2lEjv+KTak8LtCpzkA883tg3qUrJ05F0YkT2XfXUgEEbtdlKjItCkUlg336EkHG
 yajyQ3JdprSndiU0jklvEbQg==

>> Add jump targets so that a bit of exception handling can be better reus=
ed
>> at the end of two function implementations.
>
> Thank you for contribution, the change is fine,

Thanks for this positive feedback.


>                                                 but not as a bugfix.

Would you like to qualify my update suggestion as a correction for
a coding style issue?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.11#n526


> Please send as a [iwl-next], when the submission window opens.

Will a patch resend really be needed for the proposed adjustment?

Regards,
Markus

