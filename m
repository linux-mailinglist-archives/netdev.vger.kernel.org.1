Return-Path: <netdev+bounces-94927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 558CA8C105B
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75BB1F23F42
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD2915279F;
	Thu,  9 May 2024 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=ycharbi.fr header.i=@ycharbi.fr header.b="EGyQrves"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ycharbi.fr (mail.ycharbi.fr [45.83.229.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8919A1482E3
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 13:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.83.229.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715261208; cv=none; b=MAeGL0NDUkhrMA81Yvw/WrOVx1M5ksXil8NytMMMUvurDYPjPWF4DAmf04+A3ESKWnFRfNGwvfUZYLZH5EzEjKl7kCAOjbryksxbQfwjgPnmdi7mxrKkWX1twvKx6f4P0wY9PyNCj8VUlA8xULPVM0Oc65ty+0DKZKTtY7I9dqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715261208; c=relaxed/simple;
	bh=n9S+TnoW45iW3c1qRGiUsfLF0iQ/FkVIWKtB8OwckPI=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=JRUH86SnEHLbxjxzt31/ToNfhsT2ndHAiWUt3cWnyDM9B1nQS8ZkvNvQaseNFjkdmanvmsSV8cnZqyXggO+GWXd4flI497y8FqD2FzR7riJ/dG+L8I3wgoyCzeuYMVQWiJdzpEjihwZ18UBeva/paWGdE3SKUd96P23jaAQep4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ycharbi.fr; spf=pass smtp.mailfrom=ycharbi.fr; dkim=pass (4096-bit key) header.d=ycharbi.fr header.i=@ycharbi.fr header.b=EGyQrves; arc=none smtp.client-ip=45.83.229.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ycharbi.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ycharbi.fr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ycharbi.fr; s=mail;
	t=1715261197; bh=n9S+TnoW45iW3c1qRGiUsfLF0iQ/FkVIWKtB8OwckPI=;
	h=Date:List-Unsubscribe:From:Subject:To:Cc:In-Reply-To:References:
	 From;
	b=EGyQrvesRWfmZbrsYLVsDRcI8H5bWqrWNoo1/l/atEyr3xPbRD/D8EY058C0NOsgX
	 FbX4Ohi0byqt4tjrPOr6MOaIP0udb7Iu57eelerCiStE8KZTI9e9gBkJQ7Zs7T61w1
	 ab397V1+3H4bUS9M0I4TZRSmrDCwYPOod1bdDR1gboTIHcMZEvw5YdZA3mghVy2ouF
	 iZOfXciPo0i7EZuLVvvs6FUH7E3/6qczKF6GCHbzpMCKr2NEcxX7pXA/UR1GjvMipH
	 F/fx62YXxTuf7j+NixZT0xw0QksUsObQrYEo18g9yDPypOOIag8G4A91+7Q7tUB/As
	 nVbx8//8V3QSbOFCmsc7gvNcYCuNxLxRSGEekEbIPft/QaJyYUNmTUiBLqmrDZrySe
	 UUqZjQBzfhQFk3gVIfquzGjPuIgbgF2eBf4yN8GAs3Aux0MD6/kHTozCfOg31l/yN8
	 ERP0vANGy4wnpRquv9jjbmlJ86VCkKrwOCY+tc76mk1N+qWFfovvhiI7btAqjU4qsG
	 9zkqCFwzZdzy8SRELJfP74BNxsfTgZ41fjXmtiVKuLhMlxntTXOen+AxOlduFziQYE
	 7hGGtkO5iUzHN5+vRy25AmpR2NunrCCM7Ub2xEMPp5OMVZIi4Yb0KzN2z697gMMRq3
	 bsuqYxnJI8LWj4Hn4kN20OPs=
Date: Thu, 09 May 2024 13:26:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: kernel.org-fo5k2w@ycharbi.fr
Message-ID: <9eaa16ac88aafb6dee36c5781ae4de7881bb03a2@ycharbi.fr>
TLS-Required: No
Subject: Re: Non-functional ixgbe driver between Intel X553 chipset and Cisco
 switch via kernel >=6.1 under Debian
To: "Jacob Keller" <jacob.e.keller@intel.com>, kernel.org-fo5k2w@ycharbi.fr,
 "Jeff Daly" <jeffd@silicom-usa.com>
Cc: anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 jesse.brandeburg@intel.com, netdev@vger.kernel.org, regressions@leemhuis.info
In-Reply-To: <4a0bf7cf-d108-49ac-ac7c-6136a070c44b@intel.com>
References: <4a0bf7cf-d108-49ac-ac7c-6136a070c44b@intel.com>
 <cbe874db-9ac9-42b8-afa0-88ea910e1e99@intel.com>
 <e16d08bf-49f6-4c51-85fa-7c368d1887b4@ycharbi.fr>
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
	*      author's domain
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*       valid
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature

Hi,

> No link detected, but it does detect this is a 10GBaseT cable.
> Interesting it doesn't report FEC or autonegotiation. Hmm.

In fact, I personally find it strange that the "Supported link modes" is =
"10000baseT/Full". A DAC is not a SFP+ 8P8C (RJ45) module. Wouldn't it be=
 more logical if the modes reported were the same as those obtained by an=
 "ethtool eth2" on the Connectx-3 side? :

Settings for eth2:
	Supported ports: [ FIBRE ]
	Supported link modes:   10000baseKX4/Full
	                        1000baseX/Full
	                        10000baseCR/Full
	                        10000baseSR/Full
	Supported pause frame use: Symmetric Receive-only
	Supports auto-negotiation: No
	Supported FEC modes: Not reported
	Advertised link modes:  10000baseKX4/Full
	                        1000baseX/Full
	                        10000baseCR/Full
	                        10000baseSR/Full
	Advertised pause frame use: Symmetric
	Advertised auto-negotiation: No
	Advertised FEC modes: Not reported
	Speed: 10000Mb/s
	Duplex: Full
	Auto-negotiation: off
	Port: Direct Attach Copper
	PHYAD: 0
	Transceiver: internal
	Supports Wake-on: d
	Wake-on: d
        Current message level: 0x00000014 (20)
                               link ifdown
	Link detected: yes


In other words, isn't the fact that the reported mode is "10000baseT/Full=
" a bug in itself?
=20
>=20Knowing the kernel is the important part, we don't have specific
> versioning of drivers in the kernel anymore.

Ok. I take note of this information.

> The steps would require that you build the kernel manually. I can
> outline the steps i would take here
>=20
>=201. get the kernel source from git.kernel.org. I place it in $HOME/git=
/linux
> 2. switch to v5.10 with 'git switch --detach v5.10'
> 2. copy the debian 5.10 config file to $HOME/git/linux/.config
> 3. build kernel with 'make -j24' (adjust -j depending on how much CPU
> you want to spend building the kernel)
> 4. install with 'sudo make -j24 modules_install && sudo make install'
> 5. reboot and select the v5.10 kernel, double check it works.
> 6. in $HOME/git/linux run 'git bisect start' to initiate the bisect ses=
sion.
> 7. First, label the current v5.10 commit as good with 'git bisect good'
> 8. Second, label the v6.1 commit as bad with 'git bisect bad v6.1'
>=20
>=20This will initiate a bisect session and will checkout the kernel
> approximately halfway between v5.10 and v6.1. For each bisection point
> it checks, run the following steps:
>=20
>=201. 'make olddefconfig' to update the configuration for this version
> 2. 'make -j24' to rebuild with the current version
> 3. 'sudo make -j24 modules_install && sudo make install' to install thi=
s
> version.
> 4. reboot into that version and check its behavior.
> 5. If it works properly then run 'git bisect good'
> 6. If it works incorrectly, then run 'git bisect bad'
>=20
>=20A new commit will be selected. It will pick one between the latest go=
od
> point and the closest bad point, essentially honing in towards the
> incorrect behavior.
>=20
>=20If for any reason a commit can't be built or tested, you can use "git
> bisect skip" and it will skip around a bit to find another point that
> can be tried.

Thank you for your and Thorsten Leemhuis's advice. I don't know whether t=
he following Bisect log will be of any help to you. However, I have deter=
mined precisely that the problem was introduced with version 6.1. If I bo=
ot into 6.0, it works perfectly. So there are fewer differences to search=
 for the problem. Here's the feedback from Bisect, but I'm still dubious =
about the relevance of this log because the =E2=80=9Cgit bisect bad v6.1=
=E2=80=9D command returned "7614896350aa20764c5eca527262d9eb0a57da63 =C3=
=A9tait =C3=A0 la fois good et bad"... I didn't really understand how it =
all worked... :

git bisect start
# good: [4fe89d07dcc2804c8b562f6c7896a45643d34b2f] Linux 6.0
git bisect good 45eb8ae5370d5df1ee8236f45df3f29103ba6e12
# bad: [830b3c68c1fb1e9176028d02ef86f3cf76aa2476] Linux 6.1
git bisect bad 7614896350aa20764c5eca527262d9eb0a57da63

I should point out that I had to switch back to Debian 11 because 12 and =
13 refuse to compile these old kernels... Anyway, I compiled the versions=
 successively and came across the difference in operation between 6.0 and=
 6.1.

> I suspect those changes must have broken the Cisco switch link behavior=
.
> I unfortunately do not know enough about this hardware or the SFI
> configuration to understand why this causes it.
>=20
>=20If you don't want to try bisect, I would suggest trying to revert tha=
t
> commit or simply replace the ixgbe_setup_sfi_x550a function with the on=
e
> from out-of-tree here. If you do that, you can rebuild just ixgbe with
> "make M=3Ddrivers/net/ethernet/intel/ixgbe" and then insert the module
> with "insmod drivers/net/ethernet/intel/ixgbe/ixgbe.ko".
>=20
>=20It seems likely that this change had unintended side effect which bro=
ke
> the Cisco switch linking.


If I do a "git revert 565736048bd5f9888990569993c6b6bfdf6dcb6d" to go bac=
k before the state of the suspected problem commit, compile kernel 6.1 an=
d boot on it, it works perfectly.
So it turns out that this is the source of the malfunction and was introd=
uced with Linux 6.1.

=20
>=20I've added Jeff Daly, in the hopes that he could provide more details=
 on
> the change.
>=20
>=20@Jeff, it seems likely that the change you made at 565736048bd5 ("ixg=
be:
> Manual AN-37 for troublesome link partners for X550 SFI") is breaking
> some other switches. It would help if you could shed some light on this
> change as otherwise we might need to revert it and once again break the
> setup you fixed.
>=20
>=20Thanks,
> Jake

Let me know if you need more information. I'll be happy to help!

Best regards.

=E2=A2=80=E2=A3=B4=E2=A0=BE=E2=A0=BB=E2=A2=B6=E2=A3=A6=E2=A0=80
=E2=A3=BE=E2=A0=81=E2=A2=A0=E2=A0=92=E2=A0=80=E2=A3=BF=E2=A1=81 Yohan Cha=
rbi
=E2=A2=BF=E2=A1=84=E2=A0=98=E2=A0=B7=E2=A0=9A=E2=A0=8B=E2=A0=80 Cordialem=
ent
=E2=A0=88=E2=A0=B3=E2=A3=84=E2=A0=80

