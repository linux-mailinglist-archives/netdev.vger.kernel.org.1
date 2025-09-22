Return-Path: <netdev+bounces-225145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3204AB8F671
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 10:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1673A9644
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 08:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F52C2F2908;
	Mon, 22 Sep 2025 08:06:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay-b03.edpnet.be (relay-b03.edpnet.be [212.71.1.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B1B13D2B2
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.71.1.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758528361; cv=none; b=R31QuCjxyoeUVR4y+bs/67JA/JyY0vOFYrqFxibdwWcBiMIYG2k9PvS+7YPV80hz4wI9sAi1UodIwnNWa/cKzvqym8dPxJ8Abt2FwMz9KyxFSfpMK9TtmkgBdjopeBrKPqeJJBDAWtpIwUTzSuMz9zERALbuxaz2wrefJtQ6iM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758528361; c=relaxed/simple;
	bh=3SqsJuoPLh3/NAoETPjLQXzke4xB5rpaZWa/xQO6bjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MGmkeRviNnXCjDUxhbMo4jHyMht7Hq7X81pdl5Pajjx4oi4baOO7X6amrEZfbhM3F5uI5zHyAbWVVbJjuMYzcfdZW/oD9sm+ePk84RurVikKnCh+fXYvIC+NyB6hZZLBsHwLxt83hZEExS9qsSuz/0sGefh2HZ+PFxxnC7X5I5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=kabelmail.de; spf=fail smtp.mailfrom=kabelmail.de; arc=none smtp.client-ip=212.71.1.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=kabelmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kabelmail.de
Received: from [192.168.177.65] (94.105.126.5.dyn.edpnet.net [94.105.126.5]) by relay-b03.edpnet.be with ESMTP id Nfbd1cZGAhyyOAzu; Mon, 22 Sep 2025 10:05:45 +0200 (CEST)
X-Barracuda-Envelope-From: janpieter.sollie@kabelmail.de
X-Barracuda-Effective-Source-IP: 94.105.126.5.dyn.edpnet.net[94.105.126.5]
X-Barracuda-Apparent-Source-IP: 94.105.126.5
Message-ID: <4683e9ea-f795-4dab-8a0a-bd0b0f4fbd99@kabelmail.de>
Date: Mon, 22 Sep 2025 10:04:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] increase MDIO i2c poll timeout gradually (including patch)
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
X-ASG-Orig-Subj: Re: [RFC] increase MDIO i2c poll timeout gradually (including patch)
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <971aaa4c-ee1d-4ca1-ba38-d65db776d869@kabelmail.de>
 <cbc4a620-36d3-409b-a248-a2b4add0016a@lunn.ch>
 <f86737b0-a0fe-49a6-aeca-9e51fbdf0f0d@kabelmail.de>
 <aM6Ng7tnEYdWmI1F@shell.armlinux.org.uk>
 <6d444507-1c97-4904-8edb-e8cc1aa4399e@kabelmail.de>
 <aM6xwq6Ns_LGxl4o@shell.armlinux.org.uk>
Content-Language: en-US
From: Janpieter Sollie <janpieter.sollie@kabelmail.de>
Autocrypt: addr=janpieter.sollie@kabelmail.de; keydata=
 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
In-Reply-To: <aM6xwq6Ns_LGxl4o@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Barracuda-Connect: 94.105.126.5.dyn.edpnet.net[94.105.126.5]
X-Barracuda-Start-Time: 1758528345
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 5357
X-Barracuda-BRTS-Status: 1
Content-Transfer-Encoding: quoted-printable
X-ASG-Debug-ID: 1758528345-24639c1e2d7b6630001-BZBGGp
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=10.0 QUARANTINE_LEVEL=10.0 KILL_LEVEL=7.0 test= 
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.125474
	Rule breakdown below
	  pts rule name              description
	 ---- ---------------------- --------------------------------------------------
	

Op 20/09/2025 om 15:53 schreef Russell King (Oracle):
> So, what we need you to do is to work out how long it takes this module
> to respond, and whether it always takes a long time to respond. Please
> add some debugging to i2c_rollball_mii_poll() to measure the amount of
> time it takes for the module to respond - and please measure it for
> several transactions.
>
> You can use jiffies, and convert to msecs using jiffies_to_msecs(),
> or you could use ktime_get_ns().
>
> Thanks.
>

All right, so I changed the modification to a more debug-friendly functio=
n (view below).
I also changed the incremental wait() function from (20+10*(10-i)) to (20=
+5*(10-i)) to be more=20
accurate.
When bringing up with "ip link set sfp-lan up", it starts printing
It keeps polling (which, I guess, is what you expect, I guess the hwmon s=
ubsystem, link=20
detection, ... )
Mostly, the output is 300-400us.
When the module is up and running, and maintenance polls happen, I saw so=
mething new:
It starts responding with a much lower value: something like 30 us. At it=
eration 10. occasionally.
i =3D 10 means "immediately", i decrements from 10 to 0.
I got no clarification for that.
The thing I'm mostly sure of, is that no commands return an error, and no=
 mii_polls time out,
but 300-400us is way too much for a loop which expects to return in 200us
...
156724.601882] i2c_rollball_mii_poll:267: mdio_bus i2c:sfp2: poll cmd suc=
cess after 348074665 ns=20
in iteration 4
[156724.941879] i2c_rollball_mii_poll:267: mdio_bus i2c:sfp2: poll cmd su=
ccess after 328077236=20
ns in iteration 4
[156725.301889] i2c_rollball_mii_poll:267: mdio_bus i2c:sfp2: poll cmd su=
ccess after 348093665=20
ns in iteration 4
[156725.661896] i2c_rollball_mii_poll:267: mdio_bus i2c:sfp2: poll cmd su=
ccess after 348075511=20
ns in iteration 4
[156726.081885] i2c_rollball_mii_poll:267: mdio_bus i2c:sfp2: poll cmd su=
ccess after 408061414=20
ns in iteration 3
[156726.441997] i2c_rollball_mii_poll:267: mdio_bus i2c:sfp2: poll cmd su=
ccess after 348189434=20
ns in iteration 4
[156726.781885] i2c_rollball_mii_poll:267: mdio_bus i2c:sfp2: poll cmd su=
ccess after 327952775=20
ns in iteration 4
[156727.831885] i2c_rollball_mii_poll:267: mdio_bus i2c:sfp2: poll cmd su=
ccess after 30037797 ns=20
in iteration 10
[156728.241880] i2c_rollball_mii_poll:267: mdio_bus i2c:sfp2: poll cmd su=
ccess after 398062738=20
ns in iteration 3
[156728.591889] i2c_rollball_mii_poll:267: mdio_bus i2c:sfp2: poll cmd su=
ccess after 338068066=20
ns in iteration 4
[156728.941888] i2c_rollball_mii_poll:267: mdio_bus i2c:sfp2: poll cmd su=
ccess after 338062605=20
ns in iteration 4
[156729.351924] i2c_rollball_mii_poll:267: mdio_bus i2c:sfp2: poll cmd su=
ccess after 398101891=20
ns in iteration 3
[156729.692014] i2c_rollball_mii_poll:267: mdio_bus i2c:sfp2: poll cmd su=
ccess after 328135697=20
ns in iteration 4
[156730.041895] i2c_rollball_mii_poll:267: mdio_bus i2c:sfp2: poll cmd su=
ccess after 337947143=20
ns in iteration 4
[156730.391997] i2c_rollball_mii_poll:267: mdio_bus i2c:sfp2: poll cmd su=
ccess after 338162758=20
ns in iteration 4
[156730.741994] i2c_rollball_mii_poll:267: mdio_bus i2c:sfp2: poll cmd su=
ccess after 337980912=20
ns in iteration 4
[156731.831897] i2c_rollball_mii_poll:267: mdio_bus i2c:sfp2: poll cmd su=
ccess after 30043259 ns=20
in iteration 10
[156732.241897] i2c_rollball_mii_poll:267: mdio_bus i2c:sfp2: poll cmd su=
ccess after 398065122=20
ns in iteration 3
[156732.581982] i2c_rollball_mii_poll:267: mdio_bus i2c:sfp2: poll cmd su=
ccess after 328157082=20
ns in iteration 4
[156732.921978] i2c_rollball_mii_poll:267: mdio_bus i2c:sfp2: poll cmd su=
ccess after 327986467=20
ns in iteration 4

...

This was an example of the output when using the patch below.
No poll command returns an error state. No poll commands time out.
all mii_poll commands return at i =3D 3 or i =3D 4,
when the sfp module is completely up, i =3D 10 occurs from time to time.

Thanks,

Janpieter Sollie

--- a/drivers/net/mdio/mdio-i2c.c=C2=A0 =C2=A0 =C2=A0 =C2=A02025-09-22 08=
:41:12.084752517 +0200
+++ b/drivers/net/mdio/mdio-i2c.c=C2=A0 =C2=A0 =C2=A0 =C2=A02025-09-22 08=
:47:20.230592266 +0200
@@ -232,6 +232,7 @@
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct i2c_msg msgs[2];
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 cmd_addr, tmp, *res;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int i, ret;
+=C2=A0 =C2=A0 =C2=A0 =C2=A0long uptime;

 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd_addr =3D ROLLBALL_CMD_ADDR;

@@ -252,14 +253,19 @@
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* SFPs. Sleep 20ms between iterations =
and try 10 times.
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i =3D 10;
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uptime =3D ktime_get_ns();
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do {
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msleep(20);
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msleep(20 + 5*(10=
-i));

 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D i2c_tran=
sfer_rollball(i2c, msgs, ARRAY_SIZE(msgs));
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_dbg(&bus->dev, "poll cmd return %d after %d ns in iteration=
 %d\n",=20
ret, (ktime_get_ns() - uptime), i);
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return ret;
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}

-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (*res =3D=3D R=
OLLBALL_CMD_DONE)
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (*res =3D=3D R=
OLLBALL_CMD_DONE) {
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_dbg(&bus->dev, "poll cmd success after %d ns in iteration %=
d\n",=20
(ktime_get_ns() - uptime), i);
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return 0;
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } while (i-- > 0);


