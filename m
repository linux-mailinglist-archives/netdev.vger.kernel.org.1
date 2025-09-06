Return-Path: <netdev+bounces-220547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 070EBB46876
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 04:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3EBC1C82DB4
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 02:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C039B14B086;
	Sat,  6 Sep 2025 02:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="uf2tfIGd"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC40E25761;
	Sat,  6 Sep 2025 02:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757125981; cv=none; b=YqjAzb+x9BwcjDeDYzbVa4qjmjK4q1O7K6mTPhnlVtCV54j5t4eCqO6Yawe211MT9wfVHxsBWvRhxrpW09am4ydMiI3dlR9MvDrdksivywUe/6elD2SgxWAA7Xejt/rwr/jde0cy8cz7S938tCo4AJNQYIqrUnS3RdtETZvAvxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757125981; c=relaxed/simple;
	bh=2Fn0LiV5EOhctlcW5hlWospDUfNwK6XjVOmcPpi74qE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=foI+KoMkpYSisgHmAkTn27WcdurhGXFMIjaHrr0Coxw+YCPueYSK1S4gk+AnEBY2OSHgo4ec4mo127uTiTp/NdCdp2MJfMOWXt08eec49hJj4I2atMM2B5kdThnURHUa/ITh6akJo48FntBzhlfgeVL4lCsO9d5OlzWFkLPOXk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=uf2tfIGd; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1757125962; x=1757730762; i=efault@gmx.de;
	bh=5NaUZzli14qT0FLyGwsvIX/Gi9EIXgaUmeFAaQy3zY4=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uf2tfIGdN1XIlnNvJEMs1ccDm/nyJ29TVFlcLGB43j77qtirjct2BmBA4ofWGFGr
	 IOj+9mi3foXdFaY5EGsdw/aax5YZjdSyeYkqmlrJ8pakAc/aNylmzW6Kbqc+snfX9
	 Y3O20gBh96yeaNm9TG8oiPqB081oPuJe04WiuKYQ+t4E9TwNUi+gKP/e3E8t1qFv0
	 EYj+FymfBGz+KcN1q2IVJDdRj9+K0TRSzBHQeXf6g4X5L8Vyvy2NOmR9ZPzKIQ1Eh
	 Vi/JfIbHIyOC6EtsvJhmq2R5odEHmO8i09BcempfjssoBYypzyiSk92yfxGU+Kue0
	 vGGg28fXsuO9hcG/Gg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.23]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxlzC-1uWyY82Mpy-00xiBh; Sat, 06
 Sep 2025 04:32:42 +0200
Message-ID: <7fc8a1db60de959fd22ae898e86683f57fb07be2.camel@gmx.de>
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
From: Mike Galbraith <efault@gmx.de>
To: John Ogness <john.ogness@linutronix.de>, Breno Leitao
 <leitao@debian.org>,  Simon Horman <horms@kernel.org>, kuba@kernel.org,
 calvin@wbinvd.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, Johannes Berg
 <johannes@sipsolutions.net>, paulmck@kernel.org, LKML
 <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, boqun.feng@gmail.com
Date: Sat, 06 Sep 2025 04:32:41 +0200
In-Reply-To: <84a539f4kf.fsf@jogness.linutronix.de>
References: 
	<isnqkmh36mnzm5ic5ipymltzljkxx3oxapez5asp24tivwtar2@4mx56cvxtrnh>
	 <3dd73125-7f9b-405c-b5cd-0ab172014d00@gmail.com>
	 <hyc64wbklq2mv77ydzfxcqdigsl33leyvebvf264n42m2f3iq5@qgn5lljc4m5y>
	 <b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt>
	 <4c4ed7b836828d966bc5bf6ef4d800389ba65e77.camel@gmx.de>
	 <otlru5nr3g2npwplvwf4vcpozgx3kbpfstl7aav6rqz2zltvcf@famr4hqkwhuv>
	 <d1679c5809ffdc82e4546c1d7366452d9e8433f0.camel@gmx.de>
	 <7a2b44c9e95673829f6660cc74caf0f1c2c0cffe.camel@gmx.de>
	 <tx2ry3uwlgqenvz4fsy2hugdiq36jrtshwyo4a2jpxufeypesi@uceeo7ykvd6w>
	 <5b509b1370d42fd0cc109fc8914272be6dcfcd54.camel@gmx.de>
	 <tgp5ddd2xdcvmkrhsyf2r6iav5a6ksvxk66xdw6ghur5g5ggee@cuz2o53younx>
	 <84a539f4kf.fsf@jogness.linutronix.de>
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
X-Provags-ID: V03:K1:K4C9TwPpkZsSrAVPYH9pDdbnj1Hz8fqdmFJUHkwfVsRay6BmJWW
 H1VbUMVbmZ1cYbpo/OpFAjZ7WZdQvYuFSkEMZ+jA0tYJpV+r/g+YLYhhq5L0Hxn89PMDjhb
 4wAsSO8rK4nXd0fXv0IMxM/QnNJrsd0G3L05Tv13TXaH29IsKsvCWUNFyPRFva4/6skVbuz
 c0ZK6zC8AeA1gFGZsUq5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h4d24tyYkmM=;oQgc4FkaKnAHiKitdpOkptr5vqv
 BT99lD75D9r2gd0wd/+f7p47QTzHu5V5RpmSzJC4yeoWXa/xwvwwdLYtWciu5W0b2s7TOuz9A
 ynkphitLiq6Ywkg34u4aIRBAFy0H7leA8Ma7KcUSsH1U1/NLiWjuFvrWcT+SmQtsxrsIapytn
 8ewDFimk/IKSuKI4DXb2tb7vbQVPH0SAt8hT9Dk/HQjL1liw3xp6kzzEdvIlqVK5GIq072Gtg
 pVXeHeLQeOg8SbMcF5Azq7Em7I1xBCkhGIfxEb+jetPe3mpa6G+LUm43lkAxJxOEyKUWfn8WB
 nimWG0UNp3tpjgVxA1sovuIIBL5rdaY+sdrZyCJX1c7bv83J91rdYLyEUvXlAsRGk6YGWokQO
 yHxqJVxz7SqUMGb8fPsA/AH860DK9A01dG+yDHB5GmYKbaAiHnM0OXHjNr+HSFEBgqb0RH48i
 /ZdhM5InKd6gJYn8DO+/NCMBfCbXKTXNIX/vm2M29ZOOekv3nFPewHriqjdRYZhOhwR1jQ+Iv
 ljqNzSLjLaVOQMmUP2Xq8UNxQ5FVyfSnT6QwttP6do8vLB0Ns/fKXCvA3EaR2ZS+7uhBztbqG
 rh4qp/1ceR0fN9NQ6SirwTz+48Si81LBfsLXCiqeDxQI+beuluJu0U//2M0AIMaJ+gf0Hwwuf
 MzOSkjVUHcuT6qcZOlHC4N6Xj7TEQS9VdICdc6Oc3AK8v1ewRgHN/C8mrHvSsTt9wu27LedOC
 MkcES1AVM00jqooVCK1AL8Vuue075BuDNgEjG69ZMr5DxUMRgWoFfnVz9ASdrUdNpbVCmqdSd
 bQ+QQfzLgEC88rJ8grjLXMk8otGfIGtmCFaJLzfgJo8uQWVEgF5KrdNhMYPFoDRRwhOBokByG
 CXh9fBgDglS2zOdhZyDNaWI6v9LMGbEm5bgJA+KN92jruhknzk9kBn+u5zE0qtF/INK21ss3e
 WnquqDX0vvuWN6bdpBUnbIqmotqRaYy9nOojvbOYFJJsp7qfwXDNJoG+5gQ9e1OjYiwtAfS+E
 36BceCp/sz+9w8KIv4ofGqiuzmvNpTfPfD94mwE9Eyr8UwSWC3udMOmm8mAvLprLruPpkPST0
 cKIfrA6vx24nPdzsCuExKglYPQDI2D/oCoR36sb+/jDE6MrYY76+uzFquvldNBJ08TY5CvamE
 fYq1eXkKVBPl3LsFBkOb65V3cF1errv1CmtgvTzXaMUfYh/tdg74SmXK+gMG/Z9G5AqqMBD/l
 ZWFrdDpXhfGqkgnTiWHkf8xgbiGlWTmiXw0sFeQl2J2Mde30WQR8WuqDrgB2qOBAwObzbmSFq
 B5CCYamWGtUhnBo97HZNlKaBo0Y3FmY1/I/S6wq+KCHx9KPNpcSex0N+Fm2RgZN8kUZ6+r/+j
 US2j7us8zG4VtIK7yeuxEPEeKJYB0NDn0V5gBvdIJAumjr/F/BfKTW3pEVFYPoMhJHVaJjHds
 jM5x6h451c+9jEt5dTqraHCRF4bd1mTlq5iLymO1utLS/gIk1ahfDyjuz4HDteq6mrIrN7XOg
 rP3cM3tWOvQEgF2TfMpWmfZIxNSxmM7o6A5e73NVy7okD2cCOB95FQbwm3MM+A3MEFByxk63L
 VFhi7g7Oye2eLVPYCT/bLyck5Sj111qxRCax08JS6RWH0Jdt8Bxsj9XUoWesvCceM65xXSZu7
 pAgvjhMpOnXlK8qoLXZkX3WGOvAVKCeyGUrADt1rMeGuZlNsTHy7whHuJSUVEE5CfTT0kYrqV
 1LTfhaZb8hrj9DGS3QiQKfQG+VgZGd3QRFrhJwFfHn21CEqZbwzt8621Tk4WdBLr5FY1U0jPD
 +U16wf6srm9GlJj3vUKJFFKp0glFEAaMLmNtmF4KnLZQfq1578GrHLNvK089bBSq8ZyauFEGy
 tUORlumvflUrIhGqirPELztMAY82RR5GGlWs76rNTrvqIPBoUBN0HX32VgkhIxZwsTkOnR07y
 4Q8qmoY7ieDjWjvOgqiTzMDPSWgzB44E1y6NwkSA6M32t2KOooHc3fxsQrpF3ijqLDt/ipu7M
 nogb4iXlhK6rU9T/nDAoXrnd9U0xxacym7BAzlnQtQm/LNH7pAEhjHXjWhR1g+iid2/596AhP
 2xNrFN2rrueUyH7kxqM1cMj9PHHZFla9rITB+WnZ8BN+9uEobW1ofbS63KK8SQ5Yf/WZ/quH6
 wthTWnR+fMepqWbRhekvL0CyNj8J9GDvx6vO88V4rIL1ytdRonv9DuPfxtxkFIR+BvybO5yM/
 QOJkzuaIGqHDbBTYJcNYz4k+A8u94z6ZSq/vA2ePE38Kw7wbtp7s8lJrl2aX/r+px4dlSraRH
 V7rQpoj+p1WDCs+9FpiRWuxia7R2lGTNb2FtAvT83EGxcNwWLKJA+Nv6GBt7L7P6vKlQIpr+1
 a1+bt2pq1Q85G6B/RnggYY191TWabU4E2R26d/7lGpL6dTJzDwAzjTVcLSIBlqOQu0gN96jZ2
 4f7wl+mMQFJn0fW2TiqilvlzeXRIW/n4+4bdgK4dJbV4J9rbLSL3A5YBNM9lUptRtc5vI/dLE
 Hi90vVh/d2shv+4XJKB4S3QGhBle9IgDsTNYm5IP1VRdWbqAxfzqDCmpzdvtxSA4mbinWM+ZS
 vWLv3S8w7nefVTLrpKMPyhLovng8pllTS+iDY+Oqf2apDEWh2McLBZxBMcCD+xglLxDIAR3x7
 IympNMcU8Cry+7Ov0lHOcLLEktOKkIuM5N+PeSjgKUvERdPiRCl97kRDC8iKfprT09zMZ1hit
 RfhM+TyeJO/KY/nCBF6z6IOe4ksOnMjSIW1d+3wI1UJ1n/mgZ4FmIH99CDj7HYyppoWckKP4a
 lH1mCN7R6rnwvWh4OTrUzjuIvf5VTB+vBT4OoPjl1bO/g8bPThXvBiI38IdEJF9Bie/korqyz
 QP635tMjRB+zDP3+OSizy3gpMsaTOzR8i6UBeHjn+DH08/12hl8B3k7V4If/ZuRRon3t1r+kT
 UUcc47sAhXcFoIeiioaQpTfTtStLnuRilESNZpE4eGs1uyjZ9fnpQEXNEPrKgNGrfnQcpjjuT
 DTPyVp1TYduuVRt5N7JaP27jHzvyOLUDMKx3SSzhUM+QPYslYW4yjbjyyumviprA3g+zekdkB
 qpwlpHEd/uXl401/RCvWTDqkyjswZR7/tPJrhqhAHzPfGmZgEKkoqCgZgcUOuneytjvpexZkm
 3YnGlFgS52e4M+kL32JaAnqGA52Ie/GeU79owwrk+CW8EKplES0mrhupsiyf1smIyFDYeWLBE
 x8UfcbvO/+GQLBpAYL67QgYvPGQR+UntZwAhvhHCETkbzyZ8XoBvKENiIndWmjlPf3HinBoDM
 n8AslVFxIr11Duf/MMOjp9zY1cXmnKxni38RaBp7pln/0GpzSsDDpfa1fEEjmh8VKzqvfW5jF
 PpK2gaXtjwabfdZxSVMblPeXS8JX+D9ioYRhCwIpgtGRccAdS6PWnYculBxvhJ+qpAh6J6UvZ
 VZCMQyVzgG/l7YrPqJsvw3ZdSAk8ZkGsi4vspUFEU5R045a8KqmJepKo6b2egsHXZ/ThyNZEm
 hLvLYjybO/R2PQ9Tch7RcKxocjxwjE8fq3V6tgbWMzvQJ5vXYfNCubAPPv7VhJqyshrqtkAhF
 sfqjnkRHnUsjq/K6Ry0jU1xq4iWI33Awr68gg50vpa7/XoiDXky5SqS64QARFP/LeGGf01Zcl
 iJwvo04IQ5rEWAdthkF4h0Ab/vxxXYGKrEsqyvcMKDeEkW2/qh0lgfCFznsBaeSinE1IPW5gT
 ePAFZ/NMTbTrvnpEjjq7ZXK2esSbHKFtVZTHgOLCPImBW8kfcUZsKT3bZ6JZS1JKxIsApCbp4
 zNQcImLDkZtZYeXa2fm1bvEry50e3f4VL9QJ9EFv0w4QdQZ2qwelQELPcEgNPWky6f96a83Or
 QUFweePn4YaCGLPMj1i5Sepq6zElSoBJwYwSiT9xUqBBGYI9Ywn9yPDpz6AuvaddnasmPGbET
 Hzt/nW0LDfe3F4TsBzitp/rzfR3izHWpyN89tILr2Z+DrURHePgqZjkxx44L4bvuryTMDNKtH
 XTLzQ7azdDB/aTctRm5Vzhng8dfowotY04ocsVxJqfzuTp1gB2/5c1UTKQkHPaKUJHAGZMsO8
 5EZWoeee8o77Ae0UgXT7J+kVuPlWkUEHj+AYIqa7+ViLJoXF39WzjOxM8NsHCREoDmo6gch6D
 LLTv+wiO/F6LlvcuaRaWBe9EekqTGSIXD1cPIXfYa6xEIfLAHhQ//tlHtyIk7lCiWCrR6+APm
 Xl1p5VhYf7CTW8R1dZvkF6RY3p9inEBhEXUZ0sC7jsz4WUkqPw2udnyriumg2+oBOM4vlmdS3
 PHDvI56e5rEnj0lS5/9NdXY4o1wOu7idXKOnIL28yD2gUFrMaihwpW22NE4Iu4J5GfO5RyqzI
 K3BcBb3EBZQqqKIxp6lZUzJZgr4/FnewjRRqdJapUT6O4NskTNHlF1I/HfrW+irw4pljBbILJ
 ok/G7HSRyDeCZByMLtqXte+cBwj4TDUWjewZ4DA8LBM6iOn1HSz3T6hfsRALia/XaII9budWB
 1cr+sLKcn4//bvNfRIoeLJYAqqj8wgj5vRPtA6NXPvAnv1bkEuyGQ6agZQkMvDEFMhVaasP2n
 3OAunbNH57HcnQaNqiNjDbecm/vii2/lU/cgnx+ciJF+iXY8YWUYCvkCUS9ZOCtJ/G/gq9vYC
 CYxf2HSZbrf/WVD1LVaZ8oVKv0+alNIbRaf27vdsi97qmaXWYDAAKsP3+iUAa54iWzSZqJqcY
 7ZT5sFhduCSBa5YqIyk

On Fri, 2025-09-05 at 14:54 +0206, John Ogness wrote:
>=20
> On 2025-08-26, Breno Leitao <leitao@debian.org> wrote:
> > On Fri, Aug 22, 2025 at 05:54:28AM +0200, Mike Galbraith wrote:
> > > On Thu, 2025-08-21 at 10:35 -0700, Breno Leitao wrote:
> > > > > On Thu, Aug 21, 2025 at 05:51:59AM +0200, Mike Galbraith wrote:
> > > =C2=A0
> > > > > > > --- a/drivers/net/netconsole.c
> > > > > > > +++ b/drivers/net/netconsole.c
> > > > > > > @@ -1952,12 +1952,12 @@ static void netcon_write_thread(struc=
t c
> > > > > > > =C2=A0static void netconsole_device_lock(struct console *con,=
 unsigned long *flags)
> > > > > > > =C2=A0{
> > > > > > > =C2=A0	/* protects all the targets at the same time */
> > > > > > > -	spin_lock_irqsave(&target_list_lock, *flags);
> > > > > > > +	spin_lock(&target_list_lock);
> > > > >=20
> > > > > I personally think this target_list_lock can be moved to an RCU l=
ock.
> > > > >=20
> > > > > If that is doable, then we probably make netconsole_device_lock()
> > > > > to a simple `rcu_read_lock()`, which would solve this problem as =
well.
> > >=20
> > > The bigger issue for the nbcon patch would seem to be the seemingly
> > > required .write_atomic leading to landing here with disabled IRQs.
>=20
> Using spin_lock_irqsave()/spin_unlock_irqrestore() within the
> ->device_lock() and ->device->unlock() callbacks is fine. Even with
> PREEMPT_RT this is fine. If you can use RCU to synchronize the target
> list, that is probably a nice optimization, but it is certainly not a
> requirement from the NBCON (and PREEMPT_RT/lockdep) perspective.

I was referring there to !RT+wireless locking meets IRQs disabled, ever
per lockdep, an intolerance shared with RT+spinlock_t.

> > In this case, instead of transmitting through netpoll directly in the
> > .write_atomic context, we could queue the messages for later delivery.
>=20
> The ->write_atomic() callback is intended to perform immediate
> transmission. It is called with hardware interrupts disabled and is even
> expected to work from NMI context. If you are not able to implement
> these requirements, do not implement ->write_atomic(). Implementing some
> sort of deferrment mechanism is inappropriate. Such a mechanism already
> exists based on ->write_thread().

Truly atomic packet blasting would be a case of happiness, but barring
that, deferment is way better than the nothing that's available to both
RT and !RT+wireless here/now.  With a .write_atomic that's really just
.write_thread, both RT and !RT+wireless managed to successfully send a
death rattle with the WIP nbcon patch.. a progression for each of them.

>=20
	-Mike

