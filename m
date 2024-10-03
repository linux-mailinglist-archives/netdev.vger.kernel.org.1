Return-Path: <netdev+bounces-131498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DEA98EAD7
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 09:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78231B23069
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 07:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5370823DF;
	Thu,  3 Oct 2024 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lZDf2yhA"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A49981AB6;
	Thu,  3 Oct 2024 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727942025; cv=none; b=FpJSSDK8VH+bB/yidmpDRKn+XxEevHb3T2Fjcpfw3aLDVFsrdey6Vx2J3RjzFzGYKqM6z2u22RrF2h/Uq86T9NidXo7FcknP9nMEcIrl4kVdIB6xTgF8dpjMq1rsdMv+6RdzhErXQ9hHPteRaG1zdoFcotR279wL8hf/TfSR+wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727942025; c=relaxed/simple;
	bh=fJjIwf6vHVPDWb2hGO6ui9S7NubFxA3r0xZK3lZ/Oo8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p50QShffJ4zk8nbN3yG20n8iJ/isRG41k0rzwHrW5PJtMhl35D59DBguulJ0RiCkwpL/KotFYNGzeRSE5Cv4A2nD/KsnPDMX0DH3mIfkaGTXSEb3VcvOjr6fQcKRlOe7lIpZKpPvDwrDhmFPjg2IKANTz8jqcCvey40H4MTNtdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lZDf2yhA; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 339AA240008;
	Thu,  3 Oct 2024 07:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727942013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9fVJAb5Wk7Sze5ekWlpALyW16KpSyRTvzi/0vqtATt4=;
	b=lZDf2yhAhWSTYO5vfdIn+AIFf/DdvUCAJQgZzky9op87BWsnD96Xh6jLE33/ExXIac4Fg6
	vYZOBLYbrDgnuiv3jRHQg+b7c5OkaAs/Pj7hY6EyZ1f7CYDovZy8AI3iCxFgF9X6yjD4aY
	F2nCBHPJNCMneiBcPzTabIZK8ifw/zTF+t+2kqfyCPIG3sF6eVfJ6Hg1dBI142kLVs/rVC
	edbQPP4EjhQA3yb6dBuDFzwHD+6Hy2415c9QH+XAjdy9ULEhmFKTM+aLGE8jXo3nFOf1iE
	BuBjvDAnNuFyybdsfm3CBBy8lxl5gG2YilqMNprND6LXmMZOzwvblqjVjzoEfQ==
Date: Thu, 3 Oct 2024 09:53:21 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Kory
 Maincent <kory.maincent@bootlin.com>, Lukasz Majewski <lukma@denx.de>,
 Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Russell King
 <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v2 1/1] Documentation: networking: add Twisted
 Pair Ethernet diagnostics at OSI Layer 1
Message-ID: <20241003095321.5a3c4e26@fedora.home>
In-Reply-To: <20241003060602.1008593-1-o.rempel@pengutronix.de>
References: <20241003060602.1008593-1-o.rempel@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Oleksji,

On Thu,  3 Oct 2024 08:06:02 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> This patch introduces a diagnostic guide for troubleshooting Twisted
> Pair  Ethernet variants at OSI Layer 1. It provides detailed steps for
> detecting  and resolving common link issues, such as incorrect wiring,
> cable damage,  and power delivery problems. The guide also includes
> interface verification  steps and PHY-specific diagnostics.

This looks nice ! If I may add some suggestions on the layout (the
content looks very good to me) :

[ ...]

> +- **Interpreting the ethtool output**:
> +
> +  - **Supported ports**: Specifies the physical connection type, such as
> +    **Twisted Pair (TP)**.
> +
> +  - **Supported link modes**:
> +
> +    - For **SPE**: This typically indicates one supported mode.
> +    - For **MPE**: Multiple link modes are supported, such as **10baseT/=
Half,
> +      10baseT/Full, 100baseT/Half, 100baseT/Full**.
> +
> +  - **Supported pause frame use**: Not used for layer 1 diagnostic
> +
> +  - **Supports auto-negotiation**:
> +
> +    - For most **SPE** links (e.g., **100baseT1**), autonegotiation is *=
*not
> +      supported**.
> +
> +    - For **10BaseT1L** and **MPE** links, autonegotiation is typically
> +      **Yes**, allowing dynamic negotiation of speed and duplex settings.
> +
> +  - **Supported FEC modes**: Forward Error Correction (FEC). Currently n=
ot
> +    used on this guide.
> +
> +  - **Advertised link modes**:
> +
> +    - For **SPE** (except **10BaseT1L**), this field will be **Not
> +      applicable**, as no link modes can be advertised without autonegot=
iation.
> +
> +    - For **MPE** and **10BaseT1L** links, this will list the link modes=
 that
> +      the interface is currently advertising to the link partner.
> +
> +  - **Advertised pause frame use**: Not used for layer 1 diagnostic
> +
> +  - **Advertised auto-negotiation**:
> +
> +    - For **SPE** links (except **10BaseT1L**), this will be **No**.
> +
> +    - For **MPE** and **10BaseT1L** links, this will be **Yes** if
> +      autonegotiation is enabled.
> +
> +  - **Link partner advertised link modes**: Relevant for **any device th=
at
> +    supports autonegotiation**, such as **MPE** and **10BaseT1L**. This =
field
> +    displays the subset  of link modes supported by the link partner and
> +    recognized by the local PHY. If autonegotiation is disabled, this fi=
eld is
> +    not applicable. Some drivers (or may be HW?) do not provide this inf=
ormation
> +    even with autonegotiation enabled on both sides - this is considered=
 as bug
> +    and should be fixed.
> +
> +  - **Link partner advertised pause frame use**: Indicates whether the l=
ink
> +    partner is advertising pause frame support. This field is only relev=
ant
> +    when autonegotiation is enabled.
> +
> +  - **Link partner advertised auto-negotiation**: Displays whether the l=
ink
> +    partner is advertising autonegotiation. If the link partner supports
> +    autonegotiation, this field will show **Yes**. If **No**, this field
> +    will be probably not visible.
> +
> +  - **Speed**: Displays the current operational speed of the interface. =
This
> +    field is especially important when **multiple link modes** are suppo=
rted.
> +    If **autonegotiation** is enabled, the speed is typically automatica=
lly
> +    selected as the **highest common speed** advertised by both link par=
tners.
> +
> +    In cases where the link is in **forced mode** and both sides support
> +    multiple speeds, it is crucial to verify that **both sides are force=
d to
> +    the same speed**. A mismatch in forced speeds between the link partn=
ers will
> +    result in link failure.
> +
> +  - **Duplex**: Displays the current duplex setting of the interface, wh=
ich can
> +    be either **Half** or **Full**. In **Full Duplex**, data can be tran=
smitted
> +    and received simultaneously, while in **Half Duplex**, transmission =
and
> +    reception occur sequentially. When **autonegotiation** is enabled, t=
he
> +    duplex mode is typically negotiated along with the speed.
> +
> +    In **forced mode**, it is important to verify that both link partner=
s are
> +    configured with the same duplex setting. A **duplex mismatch** (e.g.=
, one
> +    side using Full Duplex and the other Half Duplex) usually does not a=
ffect
> +    the link stability, but it often results in **lower performance**, w=
ith
> +    symptoms such as reduced throughput and possible present packet coll=
isions.
> +
> +  - **Auto-negotiation**: Indicates whether auto-negotiation is enabled =
on the
> +    **local interface**. This shows that the interface is set to negotia=
te
> +    speed and duplex settings with the link partner. However, even if
> +    **auto-negotiation** is enabled locally and the link is established,=
 the
> +    link partner might not be using auto-negotiation. In such cases, man=
y PHYs
> +    are capable of detecting a **forced mode** on the link partner and
> +    adjusting to the correct speed and duplex.
> +
> +    If the link partner is in **forced mode**, the **"Link partner
> +    advertised"** fields will not be present in the `ethtool` output, as=
 the
> +    partner isn't advertising any link modes or capabilities. Additional=
ly, the
> +    **"Link partner advertised"** fields may also be missing if the **PHY
> +    driver** does not support reporting this information, or if the **MAC
> +    driver** is not utilizing the Linux **PHYlib** framework to retrieve=
 and
> +    report the PHY status.
> +
> +  - **Master-slave configuration**: Indicates the current configuration =
of the
> +    **master-slave role** for the interface. This is relevant for certain
> +    Ethernet standards, such as **Single-Pair Ethernet (SPE)** and high-=
speed
> +    Ethernet configurations like **1000Base-T** and above, where one dev=
ice
> +    must act as the **master** and the other as the **slave** for proper=
 link
> +    establishment.
> +
> +    In **auto-negotiation** mode, the master-slave role is typically neg=
otiated
> +    automatically. However, there are options to specify **preferred-mas=
ter**
> +    or **preferred-slave** roles. For example, switches often prefer the=
 master
> +    role to reduce the time domain crossing delays.
> +
> +    In **forced mode**, it is essential to manually configure the master=
-slave
> +    roles correctly on both link partners. If both sides are forced to t=
he same
> +    role (e.g., both forced to master), the link will fail to establish.
> +
> +    A combination of **auto-negotiation** with **forced roles** can lead=
 to
> +    unexpected behavior. If one side forces a role while the other side =
uses
> +    auto-negotiation, it can result in mismatches, especially if both si=
des
> +    force overlapping roles (preferring overlapping roles is usually not=
 a
> +    problem). This configuration should be avoided to ensure reliable li=
nk
> +    establishment.
> +
> +  - **Master-slave status**: Displays the current **master-slave role** =
of the
> +    interface, indicating whether the interface is operating as the **ma=
ster**
> +    or the **slave**. This field is particularly relevant in **auto-nego=
tiation
> +    mode**, where the master-slave role is determined dynamically during=
 the
> +    negotiation process.
> +
> +    In **auto-negotiation**, the role is chosen based on the configurati=
on
> +    preferences of both link partners (e.g., **preferred-master** or
> +    **preferred-slave**). The **master-slave status** field shows the ou=
tcome
> +    of this negotiation.
> +
> +    In **forced mode**, the master-slave configuration is manually set, =
so the
> +    **status** and **configuration** will always be the same, making thi=
s field
> +    less relevant in that case.
> +
> +  - **Link detected**: Displays whether the physical link is up and runn=
ing.
> +
> +  - **Link Down Events**: Tracks how many times the link has gone down. =
A high
> +    number of **Link Down Events** can indicate a physical issue such as=
 cable
> +    problems or instability.
> +
> +  - **Signal Quality Indicator (SQI)**: Provides a score for signal stre=
ngth
> +    (e.g., **7/7**). A low score indicates potential physical layer
> +    issues like interference.
> +
> +  - **MDI-X**: Indicates the MDI/MDI-X status, typically relevant for **=
MPE**
> +    links.
> +
> +  - **Supports Wake-on**: Shows whether Wake-on-LAN is supported.
> +    Not used for layer 1 diagnostic.
> +
> +  - **Wake-on**: Displays whether Wake-on-LAN is enabled (e.g., **Wake-o=
n: d**
> +    for disabled). Not used for layer 1 diagnostic.

(sorry for the long scroll down there) This whole section is more of a
documentation on what ethtool reports rather than a troubleshooting
guide. I'm all in for getting proper doc for this, but maybe we could
move this in a dedicated page, that we would cross-link from that guide
?

[ ... ]

> +List of Twisted Pair Ethernet Link Modes
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Twisted pair Ethernet variants utilize copper cabling with pairs of wires
> +twisted together to reduce electromagnetic interference (EMI). These lin=
k modes
> +are widely used in local area networks (LANs) due to their balance of
> +cost-effectiveness and performance.
> +
> +Below is a list of Ethernet link modes that operate over twisted pair co=
pper
> +cabling. Half and Full duplex variants are combined where applicable.

This section below looks to be in the same ballpark. We already have a
documentation on *some* of the MII flavours (SGMII, 1000BaseX, RGMII, etc.),
maybe we would merge the various linkmodes from the MII side and the
MDI side in the same document ?

There's sometimes a misunderstanding of the various linkmodes from
developers themselves, I think this would warrant its own section.

> +- **10baseT Half/Full**:
> +
> +  - The original Ethernet standard over twisted pair cabling.
> +  - Supports both half-duplex and full-duplex modes.
> +
> +- **10baseT1L Full**:
> +
> +  - Long-reach variant of Ethernet over a single twisted pair.
> +  - Supports **autonegotiation** and offers two signal amplitude options:
> +
> +    - **2.4 Vpp** for distances up to **1000 meters**.
> +    - **1 Vpp** for distances up to **200 meters** (used in hazardous
> +      environments).
> +
> +  - Primarily used in industrial and building automation environments.
> +
> +- **10baseT1S Half/Full**:
> +
> +  - Short-reach variant of Ethernet over a single twisted pair.
> +  - Does not support autonegotiation, targeting **fast link establishmen=
t within
> +    ~10 ms**.
> +  - Primarily designed for compact locations, such as automotive environ=
ments,
> +    where sensors and actuators are clustered.
> +  - Supports **multidrop (point-to-multipoint)** configurations, typical=
ly used
> +    to connect clusters of sensors.
> +
> +- **100baseT Half/Full**:
> +
> +  - Also known as Fast Ethernet.
> +  - Operates at 100 Mbps over twisted pair cabling.
> +  - Supports both half-duplex and full-duplex modes.
> +
> +- **100baseT1 Full**:
> +
> +  - Operates at 100 Mbps over a single twisted pair.
> +  - Does not support autonegotiation, targeting **fast link creation wit=
hin
> +    ~10 ms**.
> +  - Primarily used in automotive and industrial applications.
> +
> +- **1000baseT Full**:
> +
> +  - Gigabit Ethernet over twisted pair cabling.
> +  - Full-duplex mode is standard and widely used.
> +  - Half-duplex mode is not supported by the IEEE 802.3ab standard but m=
ay be
> +    present in some hardware implementations.
> +
> +- **1000baseT1 Full**:
> +
> +  - Gigabit Ethernet over a single twisted pair.
> +  - Does not support autonegotiation, targeting **fast link creation wit=
hin
> +    ~10 ms**.
> +  - Primarily targeted for automotive and industrial use cases.
> +
> +- **2500baseT and 5000baseT Full**:
> +
> +  - Multi-Gigabit Ethernet standards.
> +  - Designed to provide higher speeds over existing Cat5e/Cat6 cabling.
> +  - Operate at 2.5 Gbps and 5 Gbps respectively.
> +
> +- **10000baseT Full**:
> +
> +  - 10 Gigabit Ethernet over twisted pair.
> +  - Requires Cat6a or better cabling to achieve full distance (up to 100=
 meters).
> +
> +Potential Layer 1 Related Issues
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +OSI Layer 1 issues pertain to the physical aspects of network communicat=
ion.
> +Some of these issues are interrelated or subsets of larger problems, imp=
acting
> +network performance and connectivity. Below is a structured overview of =
common
> +Layer 1 issues, grouped by their relationships:
> +
> +Cable Damage and Related Issues
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +- **Cable Damage**:
> +
> +  - **Description**: Physical damage to the Ethernet cable, including cu=
ts,
> +    bends, or degradation due to environmental factors such as heat, moi=
sture,
> +    or mechanical stress.
> +  - **Symptoms**: Intermittent connectivity, reduced speed, or no link.
> +  - **Detection**: Cable testers or PHY diagnostics with time-domain
> +    reflectometry (TDR) support.
> +
> +  - **Subsets of Cable Damage**:
> +
> +    - **Open Circuit**:
> +
> +      - **Description**: A break or discontinuity in the cable or connec=
tor
> +        resulting in no electrical connection.
> +      - **Symptoms**: No link is detected.
> +      - **Detection**: PHY diagnostics can report "Open Circuit".
> +    - **Short Circuit**:
> +
> +      - **Description**: An unintended electrical connection between two=
 wires
> +        that should be separate.
> +      - **Symptoms**: The link may not establish, or the link may drop r=
epeatedly.
> +      - **Detection**: Cable testers or PoE/PoDL power detection circuit=
s may
> +        detect excessive current draw.
> +    - **Impedance Mismatch**:
> +
> +      - **Description**: Poor cable quality or incorrect termination cau=
ses
> +        reflections of the signal due to impedance variations.
> +      - **Symptoms**: Reduced signal quality, intermittent connectivity =
at
> +        higher speeds.
> +      - **Detection**: TDR diagnostics can detect impedance mismatches.
> +
> +Wiring Issues
> +^^^^^^^^^^^^^
> +
> +- **Incorrect Wiring or Pinout**:
> +
> +  - **Description**: Incorrect pair wiring or non-standard pin assignmen=
ts can
> +    cause link failure or degraded performance.
> +  - **Symptoms**: No link, reduced speed, or high error rates, especiall=
y in
> +    multi-pair Ethernet standards (e.g., 1000BASE-T).
> +  - **Detection**: Modern PHYs may detect and correct some wiring errors
> +    (e.g., MDI/MDI-X auto-crossover), but cable testers provide the most
> +    reliable diagnostics.
> +
> +  - **Subsets of Incorrect Wiring**:
> +
> +    - **Miswired Pairs in Multi-Pair Link Modes**:
> +
> +      - **Description**: In multi-pair standards like 10BASE-T, 100BASE-=
TX, or
> +        1000BASE-T, miswired pairs can cause link failures.
> +      - **Symptoms**: Incompatible wiring may work for some speeds (e.g.,
> +        100BASE-TX) but fail for higher speeds (e.g., 1000BASE-T).
> +      - **Detection**: Cable testers or PHY diagnostics may identify the=
 issue.
> +
> +    - **Polarity Reversal within Pairs**:
> +
> +      - **Description**: The positive and negative wires within a pair a=
re
> +        swapped.
> +      - **Symptoms**: No link or intermittent connection unless modern P=
HYs with
> +        automatic polarity correction are in use.
> +      - **Detection**: Modern PHYs can detect and correct polarity rever=
sal.
> +        Some expose polarity status in diagnostic registers.
> +
> +    - **Split Pairs**:
> +
> +      - **Description**: The two wires of a pair are split across differ=
ent
> +        pairs, reducing the effectiveness of signal twisting.
> +      - **Symptoms**: Increased crosstalk, higher error rates, and inter=
mittent
> +        link drops, particularly at higher speeds like 1000BASE-T.
> +      - **Detection**: Cable testers can detect split pairs, and error c=
ounters
> +        in the PHY may provide an indication.
> +
> +Environmental and External Factors
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +- **Electromagnetic Interference (EMI)**:
> +
> +  - **Description**: External electromagnetic fields can interfere with =
Ethernet
> +    signals, particularly in unshielded twisted pair (UTP) cables.
> +  - **Symptoms**: Increased transmission errors, reduced speed, or inter=
mittent
> +    link drops.
> +  - **Detection**: Error counters in the PHY or signal quality indicator=
s (SQI)
> +    may help diagnose EMI issues.
> +
> +- **Environmental Factors**:
> +
> +  - **Description**: External environmental conditions such as temperatu=
re
> +    extremes, moisture, UV exposure, or mechanical stress can degrade th=
e cable
> +    or connectors, leading to signal degradation.
> +  - **Symptoms**: Increased error rates, intermittent connectivity, or l=
ink
> +    failure.
> +  - **Detection**: Error counters and physical inspection can reveal iss=
ues
> +    related to environmental degradation.
> +
> +  - **Related Issues**:
> +
> +    - **Excessive Cable Length**:
> +
> +      - **Description**: Exceeding the maximum allowed cable length for =
a given
> +        standard can lead to signal loss and degradation.
> +      - **Symptoms**: Intermittent connectivity, reduced speed, or no li=
nk.
> +      - **Detection**: TDR diagnostics can measure the cable length. Err=
or
> +        counters may show performance degradation.
> +
> +Cable Quality and Type
> +^^^^^^^^^^^^^^^^^^^^^^
> +
> +- **Use of Incorrect Cable Type**:
> +
> +  - **Description**: Using a cable that doesn=E2=80=99t meet the require=
d standards for
> +    a specific Ethernet mode (e.g., using CAT5e for 10GBASE-T) or improp=
er
> +    shielding.
> +  - **Symptoms**: Reduced link speed, increased errors, or no link.
> +  - **Detection**: PHY diagnostics such as SQI and cable testers can hel=
p detect
> +    cable quality issues.
> +
> +  - **Related Issue**:
> +
> +    - **Shielding Problems**: Improper or incomplete attachment of the s=
hield
> +      can lead to similar symptoms as EMI issues. Variants include:
> +
> +      - **Unattached Shielding**: Shielding present but not connected at=
 the
> +        connector.
> +      - **Unconnected Device Ports**: Even if the shield is attached, th=
e device
> +        port may not provide a connection.
> +
> +Hardware Issues
> +^^^^^^^^^^^^^^^
> +
> +- **Faulty Network Interface Cards (NICs) or PHYs**:
> +
> +  - **Description**: Malfunctioning hardware components such as NICs or =
PHYs may
> +    cause link problems.
> +  - **Symptoms**: Network performance degradation or complete failure.
> +  - **Detection**: Some PHYs and NICs perform self-tests and may report =
errors
> +    in system logs. Swapping hardware may be required to diagnose these =
issues.
> +
> +Pair Assignment Issues in Multi-Pair Link Modes
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Ethernet standards that use **two or more pairs** of wires - such as
> +**10BASE-T**, **100BASE-TX**, **1000BASE-T**, and higher - require corre=
ct pair
> +assignments for proper operation. Incorrect pair assignments can cause
> +significant network problems, especially as data rates increase.
> +
> +Multi-Pair Link Modes
> +^^^^^^^^^^^^^^^^^^^^^
> +
> +- **Applicable Ethernet Standards**:
> +
> +  - **10BASE-T** (10 Mbps Ethernet)
> +  - **100BASE-TX** (Fast Ethernet)
> +  - **1000BASE-T** (Gigabit Ethernet)
> +  - **2.5GBASE-T**, **5GBASE-T**, **10GBASE-T**
> +
> +Pin and Pair Naming Conventions
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +In Ethernet troubleshooting, understanding pin, pair, and color-coding
> +conventions is essential, especially when physical cable repairs are nec=
essary.
> +One major challenge arises in the field when a damaged cable pair needs =
to be
> +identified and fixed without the ability to replace the entire cable. Wh=
ile
> +Linux diagnostics typically only provide pair names (e.g., "Pair A"), th=
ese
> +names do not directly map to the color codes commonly used for cable
> +identification in the field.
> +
> +To further complicate the issue, different standards=E2=80=94such as **T=
IA-568** and
> +**IEEE 802.3**=E2=80=94use varying conventions for assigning pins to pai=
rs, and pairs
> +to color codes. For example, the pair names reported in diagnostics must=
 be
> +translated into physical wire colors, which differ between **TIA-568A** =
and
> +**TIA-568B** layouts. This translation process is crucial for accurately
> +identifying and repairing the correct cable pair.
> +
> +Although Linux diagnostic tools provide valuable information, their focu=
s on
> +pair names can make it challenging to map these names to the physical ca=
ble
> +layout, particularly in fieldwork where color-coded wires are the primar=
y means
> +of identification. This section aims to highlight this problem and provi=
de
> +enough background on pin, pair, and color-coding conventions to assist w=
ith
> +analyzing and addressing these issues. While this guide may not fully re=
solve
> +the difficulties, it offers important context to help bridge the gap bet=
ween
> +diagnostics and physical cable repair.
> +
> +TIA-568 Pair and Pin Assignments
> +""""""""""""""""""""""""""""""""

This section here as well could be in another page (standalone or the
same as above) ?

My idea would be to make it a bit easier to read through the
troubleshooting guide, with on one side step-by-step instructions,
crosslinking to a page containing these detailed descriptions.


[ ... ]

> +Linux Kernel Recommendations for Improved Diagnostic Interfaces
> +---------------------------------------------------------------
>=20
> +As of **Linux kernel v6.11**, several improvements could be implemented =
to
> +enhance the diagnostic capabilities for Ethernet connections, particular=
ly for
> +twisted pair Ethernet variants. These recommendations aim to address gap=
s in
> +diagnostics for OSI Layer 1 issues and provide more detailed insights fo=
r users
> +and developers.
> +
> +This list will evolve with future kernel versions, reflecting new featur=
es or
> +refinements. Below are the current suggestions:

I'm not sure this TODO list has its place in this troubleshooting
guide. I agree with the points you list, but this looks more like a
roadmap for PHY stuff to improve. I don't really know where this list
could go and if it's common to maintain this kind of "TODO list" in the
kernel doc though. Maybe Andrew has an idea ?

Thanks for coming-up with such a detailed guide. I also have some "PHY
bringup 101" ideas on the common errors faced by developers, and this is
document would be the ideal place to maintain this crucial information.

Maxime

