Return-Path: <netdev+bounces-221315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C002DB501E2
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62FA5169120
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBE725B30E;
	Tue,  9 Sep 2025 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="XxwXet75"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904031459F6;
	Tue,  9 Sep 2025 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432984; cv=none; b=tg49noySo26lbKr3Ra1nYIGRbWUhTGEBTfwcFnw9Tm/QB0iBIS1rr9EFZ8SEPeRoRjDi2z0nypOvFGkb8HC4NpZ9WzfzDyu/i6Uz6SoKnKyhAxs6zHdZF5tUdnpmTqUrKO1F6q3U7QCoBu5T+ewxUkcILEAx+H678btwjW7Y0Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432984; c=relaxed/simple;
	bh=LoqYoieXP6DbLLMIDTelgvoPD+eUId9A7WDNlSwAfz8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EwJh3NHBb/hnodsXmzwm3zGJJDTLRmQ0tZrpET/BZnEpsAs6NzxvzLmeAuijVbEk/U+pIYY/uXsMCtVBa/YEhgD0UEMzzH19A7mBLawmhMIgOlYdCejEhdXWRsAMTvd6hT1bv7hHgg+1w/jrgJimz+N9LrwAG7CC/kdqcWAL8u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=XxwXet75; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1757432965; x=1758037765; i=efault@gmx.de;
	bh=p7oNun/26q/9xrQ1NCoOO9/Uuv0u56NIebJdDu+RVcc=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XxwXet757bRaI8qX2sGpIPFK1L/tRHygM05tN2hZxl0QuGyMwugZ/bGWYuZeAPxk
	 LVQslp1mP8wc+oluNwqbtSmgOYaFCr+cnGkfzGTZLTuDwdbnZSG9+fEkadSpA3h0J
	 qwafpHEmGcQudSb7eSQQ2eqMGKiHJOBpJ1vDJUZgLutudl66fcjgx4BLMLQZ0kq0e
	 fJB+PLbohVMZdX/5+NYkiDASCKDyO2EcQ/rX7OjgD5zwYg97k3hy/Ou2kERhnOoLk
	 TovHbo3rQS+DW7aZrsjCjIG13FlR70FFSAkkCPaTu/wFbjpYCmBOn63GRYZgjVllU
	 RN7PL9H6xU2afc58fA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.51]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N33ET-1uHg3k1rjx-018Cik; Tue, 09
 Sep 2025 17:49:25 +0200
Message-ID: <6943b4ab95056019eae5780d23232b3ef237a49f.camel@gmx.de>
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
From: Mike Galbraith <efault@gmx.de>
To: Calvin Owens <calvin@wbinvd.org>, John Ogness
 <john.ogness@linutronix.de>,  Breno Leitao <leitao@debian.org>
Cc: Simon Horman <horms@kernel.org>, kuba@kernel.org, Pavel Begunkov
 <asml.silence@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
 paulmck@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 netdev@vger.kernel.org,  boqun.feng@gmail.com
Date: Tue, 09 Sep 2025 17:49:24 +0200
In-Reply-To: <aL88Gb6R5M3zhMTb@mozart.vkv.me>
References: 
	<hyc64wbklq2mv77ydzfxcqdigsl33leyvebvf264n42m2f3iq5@qgn5lljc4m5y>
	 <b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt>
	 <4c4ed7b836828d966bc5bf6ef4d800389ba65e77.camel@gmx.de>
	 <otlru5nr3g2npwplvwf4vcpozgx3kbpfstl7aav6rqz2zltvcf@famr4hqkwhuv>
	 <d1679c5809ffdc82e4546c1d7366452d9e8433f0.camel@gmx.de>
	 <7a2b44c9e95673829f6660cc74caf0f1c2c0cffe.camel@gmx.de>
	 <tx2ry3uwlgqenvz4fsy2hugdiq36jrtshwyo4a2jpxufeypesi@uceeo7ykvd6w>
	 <5b509b1370d42fd0cc109fc8914272be6dcfcd54.camel@gmx.de>
	 <tgp5ddd2xdcvmkrhsyf2r6iav5a6ksvxk66xdw6ghur5g5ggee@cuz2o53younx>
	 <84a539f4kf.fsf@jogness.linutronix.de> <aL88Gb6R5M3zhMTb@mozart.vkv.me>
Autocrypt: addr=efault@gmx.de;
 keydata=mQGiBE/h0fkRBACJWa+2g5r12ej5DQZEpm0cgmzjpwc9mo6Jz7PFSkDQGeNG8wGwFzFPKQrLk1JRdqNSq37FgtFDDYlYOzVyO/6rKp0Iar2Oel4tbzlUewaYWUWTTAtJoTC0vf4p9Aybyo9wjor+XNvPehtdiPvCWdONKZuGJHKFpemjXXj7lb9ifwCg7PLKdz/VMBFlvbIEDsweR0olMykD/0uSutpvD3tcTItitX230Z849Wue3cA1wsOFD3N6uTg3GmDZDz7IZF+jJ0kKt9xL8AedZGMHPmYNWD3Hwh2gxLjendZlcakFfCizgjLZF3O7k/xIj7Hr7YqBSUj5Whkbrn06CqXSRE0oCsA/rBitUHGAPguJfgETbtDNqx8RYJA2A/9PnmyAoqH33hMYO+k8pafEgXUXwxWbhx2hlWEgwFovcBPLtukH6mMVKXS4iik9obfPEKLwW1mmz0eoHzbNE3tS1AaagHDhOqnSMGDOjogsUACZjCJEe1ET4JHZWFM7iszyolEhuHbnz2ajwLL9Ge8uJrLATreszJd57u+NhAyEW7QeTWlrZSBHYWxicmFpdGggPGVmYXVsdEBnbXguZGU+iGIEExECACIFAk/h0fkCGyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEMYmACnGfbb41A4AnjscsLm5ep+DSi7Bv8BmmoBGTCRnAJ9oXX0KtnBDttPkgUbaiDX56Z1+crkBDQRP4dH5EAQAtYCgoXJvq8VqoleWvqcNScHLrN4LkFxfGkDdqTyQe/79rDWr8su+8TH1ATZ/k+lC6W+vg7ygrdyOK7egA5u+T/GBA1VN+KqcqGqAEZqCLvjorKVQ6mgb5FfXouSGvtsblbRMireEEhJqIQPndq3DvZbKXHVkKrUBcco4MMGDVucABAsEAKXKCwGVEVuYcM/KdT2htDpziRH4JfUn3Ts2EC6F7rXIQ4NaIA6gAvL6HdD3q
	y6yrWaxyqUg8CnZF/J5HR+IvRK+vu85xxwSLQsrVONH0Ita1jg2nhUW7yLZer8xrhxIuYCqrMgreo5BAA3+irHy37rmqiAFZcnDnCNDtJ4sz48tiEkEGBECAAkFAk/h0fkCGwwACgkQxiYAKcZ9tvgIMQCeIcgjSxwbGiGn2q/cv8IvHf1r/DIAnivw+bGITqTU7rhgfwe07dhBoIdz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:vquQysvJ+NbU6wjIeRNAwp5PR/7T+4wtT4EbUqeI2QkOJyO2+2H
 tKEE0/5jJZybtOzwAHk4u4HzbyqJj6+oVzpShHj32K6B0994E71zcd2eGaB2gNlMzZMm1ir
 aGqbVKHl1VN0jILMwK+nEYvbQxdbhU0RHuwPnNY1ldFMpqdTmoyeeTJzd5JKEa2bR/SaxVd
 m7P9RoK7Y/NQUyPld/wCw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GUlTUmQCex0=;mBC+zmgTkP8CcPNy3pSVQ7bian1
 MyUnoY3tITyvNnv76Ylh7KXODDNgcH8/ltlcjUIiE5paMigGPvN2J2fe2SYLOllfawM0MSgOK
 NfcoOfQgC7JLYdkijXK0IkqydntHsthKWapjS4MIVR6Q56AIZ0pL1tCnD9FhOQIAt5ftyaLWj
 T9RgWqZjdPLYMzY57oOgyhaC+ebRcW1RmaZ0O/tHf2F018ljeW57IBto/3dAjC2ZGIkkYV9Mo
 xdNcb+oLDpYiTSHeS1eLD2C1pLgNPojCmOW9EUjbaWyDMJFHgRSAH4NhfEW6s5lfGOOZFnrrK
 cAiB6N03yIukc8cx5o7S/bfwidPSQ6NjGRf2g9BmzKthh7KIC1piRScOjf7UgeBpIxjPdap6D
 /+r3VMqOu4Rrr/jGNpk35X2sGiE9xMvMXDVGq7trRIHgy1/6JVLGECXlGeGtp9k88grp31VAI
 btw7FtA2Bu3tIxi+smw/yz4Hbx9xT2pX7zdcu2KM1U4WppltOmdaBplnzSv5e5RHTegBU1v4p
 N+0nPZ4sWEvfbVsovzw+LqDIQd3WeWcklhx0xC0CgrBH9CMfvHrdm9nDhMpOoKZYA8ei2g46X
 xgsja94YkCww8teibDGn2rw029iXMLULBnG2cbEzobh+pXD3YEpsM2SVHS3TwOqDeRPCo8W4W
 qna/Ijvh0vdaPAaNbNccicFxETg97LhbxF9Ok4v6QeNFnBoRHZeO0k3mXE7VwOjLSHuWEfj7/
 yEOfn9LDMiToLu5IoMoSElzUiXY6e+kwEhqeSyhkX0j0o7+b3bhz5tRMLyOJvNwFiHEj9qlgl
 LdsEvZrpX5WgtVHs2PyTMyV2hNBcfuu/vHRlP7Q0b+mZ0yICvqLh3ktz1AfTuE76DXgKnP1pa
 PUun29ex67glVT+wPfPUKTKsy0cVatz0UJQiDzvE3TyLEvvAcz/2/j1Ko5kilud7tdhZF8HQs
 mvZonnU6y1XcxKIV6Upb0g8ePxRcYNA6VMzXyyLs1KyHJ6C1JfdE2txHrHGLm6RFpF6xRu9Ij
 Li5CtygJTozPELpCnShDQkv2y5xyKSh2TE0f5QBzoE75mx8Bdj1//Xf8aP2aD83/QL1zxt3Us
 TbgEVW047rF1fK1XAV5VSOTfn7+CMuHSEyTexDdd5jKVCwqJEHwXwlCBoMUt8vo+jZzTVWcJ8
 zkWEQyUGsSpJw7EzyapYb7lYrUHWe4vOpqUdXHp4pou+x2stpx8ctOpb54eWRardrIBYhDEnR
 xMdwTuBxvx6IQGT/YEkG65JYanLTS/vUrjUM+hB+gpfwwABTChQ8HmpCbBbXSxq3oQe35l2rO
 b656Z3023hPkFOnLlLSjlbCjROqwYvBiXoGaX2/x1wye56ONJ4urxLbIUHwx/8f5a4YgWY3hl
 d3i57wfueW/azyVq95Of9TVd7+6zVKwCoH2ZyGDLU9Q69cT0TSyHp6VJaoBKqlH9nSIyfnSRi
 KnQtedYuwOl8wmO9WUneys+253/hfZrJxXBGcefjMcDWycnASWjSO5mynQRktdjN5G6MOn6aj
 w7Q7oISQOVcI9T60VYZVjMESKu5z0uH8gNo0Il2aklGNjZ01t++V0QLfUlNiomJo0Kj2tLMqv
 i7cjAha83nguZa9MEI8TcRlQF3qTfGXWUde6DZN/0ByikKx2n3LAlIyJcn1t8rsBSz4cQ5mQm
 iCPF0iXkb7ytGSiVvFFoFxybEdBp2rQ/4ECu21TB9EL1dfbJ0gent+GPbnuzM2WP4x2rrVwge
 MGKg1rOpAdk+w7o8SvosywwkF2vY328kNpQ2d7l3uRWmhihwR8qgCfHVITDqhsDccdQZXD8nT
 vpsOm0VXDKhLtsfyzRVSzdQgJnj/pdOcQ1vN156iMgHTwdMguez5gM+cZBTqp3aLKKtUzmpOq
 aZ5Ln5mFxp7GzD5I8WM7B7VultDvmBSkjZMtTsO3zrdfETp3lyAHyScA08bttcCHVCXuKySkv
 Q/HPoDqIUOEvQKlCZeot26V3JKGyhzmVEIY7r8yaRksr+RIKzcWaSiD6XwBg3kVpkKtmXVn5L
 UO8TnY4L4onG1CZOp+nlGDe2m7Ob2XVx2LMJFo54sCviLO36QvWuOEVOI3HODHTN1Uxh102qf
 XzyhAySUpSeFsgCvyKhF8hfY19Eu1j+b5Vr4VaHvnvz+lYh9Bnhujq2fOm6ubnsU5gs5cXCqk
 kxKyogKHUDv3ADUGOAW7xZTq+I+8kf+Qr9W8WVD7h1aLyXLk/IRedb++M9mcu0W4KXSH1YCm2
 dqikTLyvfdvG+M7RWKI7hRV8R6omwjHxeGf/2ufrwUtnzPZpaNxDp/CelO40TMAzUarxVk0HC
 DEadcKR9OE/CkpPUgHQKBIiLCqPESPKACuRSqNkQDd/o2e1XUyd+e/h4AXzz8/Ca6IVcDPw8j
 /9+NIxlEu0lReOiD5KXkbREjvkyF9S2D0z8rL2AfE+Ik5/1MpqPE3LLVUIn3MsFU0TzJkzMGd
 yxtyLBWjLmpcetgsJ3jSQv/loXVf+s5T+6RNFejidQBe16/NwYGyAD+QQ4c10dU/WW0ZaEq3+
 u/P8K0LqcBiBr5T8abshDIwTtXPW3n014sex53JqYl/RP4x4f7NsjBkaRisg+yoV5P42pcgtA
 CPYdIqrPMOGjWo7xEbDHp0Nx53sk0dsXAC7XFcMeEUktErxz3X5zX+bptT2gv2jtu8h3tGW8f
 n4R5LBDnxgJ2jXbHj7Qfx3taavB//ts/OSz8RC4fhxvOdGpqJgxoH0RD9IohSzBCefNqg+tR1
 ybcCjU+ujF0/BfgD0BKwwRPZjdBx6MPNv0TJzqYvfuMXVdcLUJbpsjZ5BR6L1SNZ0uKA50wx3
 FhDe9XhL7+y7uGqYBwZy6Xa8x7wd/cHhJu1OTa3V5vco7fPa3SnzlAxzwH6hCz75uXVCmV0TT
 SjXvOcr8Y++GCdF/9/xac6RmuTWCisEEFx1TqarsJkIcyzMx/9m5QyD4fzVUMG08abiEGxIkZ
 isLzqbYjpzMiutkAoO3rKP1DwXmgAGg0ms0VwqmX4XR4fwhIxd/2373aCDWGI+3GZLZu/O2DQ
 wrPoI0P+5838M33H8z575E9XmQg+Ew9GMUmh08d7bzYlvwBSfnRp9XJF07GmcU2HRUHqh28fm
 cFtPk7aqlbeLVAuXJ7gmHSSO6IJ/zlQ+M2S9w8TTeG3YDMW5bPgNng0iF+lpT+T800VgufYD2
 o50cy5L7YVaAo5ygJDcyWx+mJDpdY1XoHG9heIpLuMVXmI2kBQJL682bxK+3Be0P/BswH8nQE
 4AtGU+PzOX7QkQ5WC73uAFe7WL/j02wLtZT3h8k71HXsPgnCkodrx1QyD0BAIa80pavC/LoYF
 blUCyoLaJmyePYUpDxBTFaL2Azz39naWZ59uThpweoxezdFb3xFzSs/+Av56DzHym7B/LRPB6
 BhNTr3To0sX11kmDl1TYFOG+/u25sqd29vpO3Kjv8sYWbElEORlTz7zmg7GcxhdtUVroaXSt9
 uUmO96J6WrBM+RfbUSHF67cqv6DO5RR440IoLtFkN/CAb+cw8RjPL42fUdPP4dUFEV8wtZmXj
 zmskSHJF+XfWS8+xqIBpWiLfmUJEfAveLZcMI39f0JAgW4Llbk5KQch1AAZQFcZWJy4Y/RwyN
 HszrYLK9nLCwiqUmETLFiPv9LEFmvwDUUuWg9QMMkaTrflmXHfvYDwVMWFql0Akj+vnQDFZ5U
 GQdlSQwmnYP7b/TYkGbzCf1WjpxjKXoxAfgjyC7yIqCKUtZe2iMFYcuVmyrh6HJdaIjFmLNZM
 H17sl7BIj8rD7B9Fr7fiLYT6ihHRd08nVaQs/3LOmfcPmS2aZuz94qy9ByBs/xolzb6LNynKM
 jXmldKZ/KTfJTTtF7c9vDlgp7wJMFMsfneLVcCqckh6bc3YHTbSxItcWpcJGjUudsn+x9aBls
 ORt8SyW5I3vltvy3mLB0fscboHcUdmbOXkXmSdDkfsPIadlmiRR4RgpBEmA5nHaM8HeHK3BUB
 yGqenq63k+ar/wjx0k7pfHLKL6SNiSMOvN/7NkqXGy2zrm1COQbFrKNZ561cp3VU0PanwJsrZ
 cZ+MofrCOiasyX1rRwoIAzUtmMnv1fCENn/AGZJS/JejUXgiRRXvJcRHvtSFVmjCImXLRnNq6
 5z4o3Rpb1BZAKjRrF2AVDxqEN+dtHY5u2TJ31Oh1A56G+bjZU9RBjETb527TW/qBp4gb6hjiv
 B9mkHrEpFzeba6xcmn18BeQAHcbtadh6kHM8bGXgkKVz+wpBxgdawdZUi0YC+DJh8ys+HtLEF
 WF3t1iPAI08LdB/nImExPIKeoj5uDPdMtQaQ2IJgYrst95xajkBCGr8adADDKNu3OANU7Suij
 PdQE3/uushhutKWz2FHDEhdsxVK3GyMrfDvKv4tO/2nWuS04nWtQI8Dy+WW85H+QXaE/pc/ws
 ZSD0WkeFKvsisGtKJQ4UwbG0WWDdqrnXX7oZX1HYu2FokB0ptgTLQf1Xe2pMZtcZNXgEOWAI5
 nczXldYOwW0AFDwcBAUMu/Xs5vO096HLwgy4a2ImaMnw0NNRSfCDm/Ln/PTG8KnKPUPCXgGC/
 avacm0A4POf9B0GQHO/CjR8oSmfwru0lvd9RKaJAZChAYh1nmaQ5TOwPA3+1zXvM3ZFg==

On Mon, 2025-09-08 at 13:27 -0700, Calvin Owens wrote:
> On Friday 09/05 at 14:54 +0206, John Ogness wrote:
> > <snip>
> >=20
> > NBCON is meant to deprecate @oops_in_progress. However, it is true that
> > consoles not implementing ->write_atomic() will never print panic
> > output.
>=20
> Below is a silly little testcase that makes it more convenient to test
> if crashes are getting out in a few canned cases, in case anyone else
> finds it useful.

I gave it a go.

> Testing this on 6.17-rc5 on a Pi 4b, I don't get any netconsole output
> at all for any crash case over wifi, so that already doesn't work. All
> the cases currently work over ethernet.

With local hackery on top of Breno's patches I captured all testcases
for RT and !RT wired and wireless except for one RT wired instance due
to a GPF_ATOMIC allocation failure.

The wireless stack was unhappy about ending up in an nbcon write_atomic
method with IRQs disabled, thus sent complaints along with the oopsen.

	-Mike=20

