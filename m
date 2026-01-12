Return-Path: <netdev+bounces-248912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8FBD111DA
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 09:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0ABBE3069280
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 08:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08664340298;
	Mon, 12 Jan 2026 08:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ENVtdbLW"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B850533C1BB;
	Mon, 12 Jan 2026 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205090; cv=none; b=GnRB+6uAmO3wP+Fye1wGstp3W2sDEQuPhQruUmSaUfIHpo6JbXYIRPfq1mv/gcRudHpuohukeMZjnW9HUVV/J3t3Gesgvc+HqMRqP7avNJkPtkDr96NnIAPprDPA8JZTFzpnmTVOpGyZk9UVvbvjGhScUjU9rySF9lHV7xa49Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205090; c=relaxed/simple;
	bh=gTbsnZPqT8TPll7gNC1Pj40/xrma7qH8XQsNdcp1gA4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UcrSAQaJsRSfxVKK74H3rM9uZnv+ti223pOeuP0jZkzgNC7c8DMWpZDVY8whwb1wo+ci4IwuCtS7PvlT14bV2SKciD9gMBed6pt1Bv21Y5D6yCCYZn4AdxlwWgBioKBrmNk8MpSIY5rWCIkfB+W0kVmBTksUWZflIUxgtAuoW4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ENVtdbLW; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gTbsnZPqT8TPll7gNC1Pj40/xrma7qH8XQsNdcp1gA4=; b=ENVtdbLWsN9m6EjXIW7FwG/Vym
	SCD9dRbfV0ki58/bu88FDBTX2sm0/WQ+fWEz67imdEbynNkJIr/6JzKK76fGSifHgwBR0SVIwtcvx
	zZPUw5SE4zevfsqqMEDMeK9cZ/jmn2ZYNFfoKZu7Vj+JNHRu82HnTubyYgA4PI/DxQ2dKK98SA/NP
	FXAocSW0yvhfTKGmk15PYKL/crNd/01R1gGUwSpqd051ZqDTP/qpDHnzr/5R3mPMuoD7pwxDUZqin
	BWq5fJ8HohVj7UxB4ME1VA2bSHJDz1WHw4TFNtctKvVowqphfDv3i/xt67x89luRJy63cVlFE9tE0
	rkOXP7qw==;
Received: from [172.31.31.148] (helo=u09cd745991455d.ant.amazon.com)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfCup-00000000E4b-30Eo;
	Mon, 12 Jan 2026 08:04:43 +0000
Message-ID: <c4090523151f1994438726686c3bc9e12c977670.camel@infradead.org>
Subject: Re: [RFC] Defining a home/maintenance model for non-NIC PHC devices
 using the /dev/ptpX API
From: David Woodhouse <dwmw2@infradead.org>
To: Wen Gu <guwen@linux.alibaba.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Richard Cochran <richardcochran@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Dust Li <dust.li@linux.alibaba.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>,  virtualization@lists.linux.dev, Nick Shi
 <nick.shi@broadcom.com>, Sven Schnelle <svens@linux.ibm.com>, Paolo Abeni
 <pabeni@redhat.com>,  linux-clk@vger.kernel.org
Date: Mon, 12 Jan 2026 08:04:43 +0000
In-Reply-To: <0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com>
References: <0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-dxATG9YWDDmi1QmA3I+b"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-dxATG9YWDDmi1QmA3I+b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-01-09 at 10:56 +0800, Wen Gu wrote:
>=20
> Hi all,
>=20
> This is an RFC to discuss the appropriate upstream home and maintenance
> model for a class of devices/drivers which expose a high-precision clock
> to userspace via the existing PHC interface (/dev/ptpX + standard PTP_*
> ioctls), but are not tied to a traditional NIC/IEEE1588 packet
> timestamping pipeline.
>=20
> Examples already in the tree include (non-exhaustive):
>=20
> - drivers/ptp/ptp_kvm.c [1]
> - drivers/ptp/ptp_vmw.c [2]
> - drivers/ptp/ptp_s390.c [3]
>=20
> There are also examples living in their respective subsystem (out of
> scope for this RFC),
> e.g. drivers/hv/hv_util.c [4] and drivers/virtio/virtio_rtc_ptp.c [5].
>=20
> We (Alibaba Cloud) also posted a driver for a CIPU-provided high-precisio=
n
> clock for review [6]. Based on existing in-tree precedent, we placed it
> under drivers/ptp/ and sent it to the netdev list.
>=20
> During review, concerns were raised that such "non-NIC / pure" PHC driver=
s
> are not a good fit for netdev maintainership [7], since they are primaril=
y
> time/clock devices rather than networking protocol features.
>=20
> As a result, I=E2=80=99m sending this RFC to align on a consistent upstre=
am home
> and maintainer model for this class of drivers, both for the existing one=
s
> and future additions.
>=20
> #
> ## Observation 1: PHC core/API are already not bound to NIC/IEEE1588
> #
>=20
> Although PHC support is original associated with NIC-based IEEE 1588
> timestamping, the kernel tree already contains multiple non-NIC PHC
> implementations (examples above), including long-standing and recently
> added drivers. This reflects the reality that the PHC interface is no
> longer tightly bound to NIC/IEEE1588 implementations.
>=20
> This is enabled by the PHC interface's clean design, it provides a
> well-scoped, layered abstraction that separates the userspace access
> mechanism (/dev/ptpX + standard ioctl semantics) from the underlying
> clock implementation and discipline method (NIC/IEEE1588 packet timestamp=
ing
> pipeline, virtualization-provided clocks, platform/firmware time services=
,
> etc.). The interface defines only generic clock-operation semantics, with=
out
> baking in assumptions about how the clock is produced or synchronized.
>=20
> Because of this elegant decoupling, the PHC API naturally fits
> "pure time source" devices as long as they can provide a stable, precise
> hardware clock. In practice, PHC has effectively become Linux=E2=80=99s c=
ommon
> API for high-precision device clocks, rather than inherently bound to
> an IEEE1588 NIC implementation.
>=20
> #
> ## Observation 2: the PHC (/dev/ptpX) has an established userspace ecosys=
tem
> #
>=20
> The PHC character device interface (/dev/ptpX + standard PTP_* ioctls) is
> a mature, stable, and widely deployed userspace API for accessing
> high-precision clocks on Linux. It is already the common interface consum=
ed
> by existing software stacks (e.g. chrony, and other applications built ar=
ound
> PHC devices)
>=20
> Introducing a new clock type or a new userspace API (e.g. /dev/XXX) would
> require widespread userspace changes, duplicated tooling, and long-term
> fragmentation. This RFC is explicitly NOT proposing a new userspace API.
>=20
> #
> ## Goal
> #
>=20
> Establish an appropriate upstream home and maintainer model for "pure tim=
e
> source" PHC drivers. If they are not suitable to be maintained under netd=
ev,
> we need a clear place and maintainer(s) for them, and a consistent policy
> for accepting new ones.
>=20
> #
> ## Proposal
> #
>=20
> 1. Reorganize drivers/ptp/ to make the interface/implementation split
> =C2=A0=C2=A0=C2=A0 explicit,
>=20
> =C2=A0=C2=A0=C2=A0 * drivers/ptp/core=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : PTP=
 core infrastructure and API.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 (e.g. ptp_chardev.c, ptp_clock.c,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptp_sysfs.c, etc.)
>=20
> =C2=A0=C2=A0=C2=A0 * drivers/ptp/pure=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : Non=
-network ("pure clock") implementation,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 they are typically platform/architecture/
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtualization-provided time sources.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 (e.g. ptp_kvm, ptp_vmw, ptp_vmclock,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptp_s390, etc.)
>=20
> =C2=A0=C2=A0=C2=A0 * drivers/ptp/*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 : Network timestamping oriented implementation,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 they primarily used together with IEEE1588
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 over the network.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 (e.g. ptp_qoriq, ptp_pch, ptp_dp83640,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptp_idt82p33 etc.)
>=20
> 2. Transition drivers/ptp/pure from netdev maintainership to
> =C2=A0=C2=A0=C2=A0 clock/time maintainership (with an appropriate MAINTAI=
NERS entry,
> =C2=A0=C2=A0=C2=A0 e.g. PURE TIME PHC), since these PHC implementations a=
re primarily
> =C2=A0=C2=A0=C2=A0 clock devices and not network-oriented. New similar dr=
ivers can be
> =C2=A0=C2=A0=C2=A0 added under drivers/ptp/pure as well.
>=20
>=20
> Possible alternatives (please suggest others):
>=20
> - Move/align "pure time source" PHC drivers under an existing
> =C2=A0=C2=A0 timekeeping/clocksource/virt area, without changing the user=
space API.
>=20
>=20
> I=E2=80=99d like to drive this discussion towards consensus, and I=E2=80=
=99m happy to
> adapt our series to match whatever direction is agreed upon.
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Da0e136d436ded817c0aade72efdefa56a00b4e5e
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D7d10001e20e46ad6ad95622164686bc2cbfc9802
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D2d7de7a3010d713fb89b7ba99e6fdc14475ad106
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D3716a49a81ba19dda7202633a68b28564ba95eb5
> [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D9a17125a18f9ae1e1233a8e2d919059445b9d6fd
> [6] https://lore.kernel.org/netdev/20251030121314.56729-1-guwen@linux.ali=
baba.com/
> [7] https://lore.kernel.org/netdev/20251127083610.6b66a728@kernel.org/
>=20
> Thanks for any input.

Thanks for starting this discussion.

I agree that the existing 'pure' PHC drivers should keep the option of
presenting themselves as PTP devices to userspace. I would probably
have suggested moving them out of drivers/ptp/=E2=80=A6 to somewhere else u=
nder
drivers/ entirely, but that's bikeshedding.

I do think we have slightly different requirements for the pure PHCs
too though, particularly the virt-focused ones. It would be good if we
could set a guest's clock from them at startup, and the primary focus
of them is for calibrating the guest's CLOCK_REALTIME. Which means we
do actually care about consuming UTC offset and leap second information
from them, not just TAI.

I'd also like microvms to be able to consume time directly, especially
from vmclock, without needing a full-blown NTP-capable userspace. I've
experimented with simulating 1PPS support to feed into the kernel's
timekeeping, although I don't think that's the best answer:=20
https://lore.kernel.org/all/87cb97d5a26d0f4909d2ba2545c4b43281109470.camel@=
infradead.org/

We could do with harmonising the workarounds for kvmclock too. I made
sure the vmclock driver reports its timestamp pairs in terms of either
CSID_X86_TSC or CSID_X86_KVM_CLK as appropriate, but ptp_kvm *only*
uses kvmclock (which is daft, since anyone who cares about accurate
time will be using tsc). I was thinking that interface of the pure PHC
drivers could be really simple, and our new infrastructure could
provide the ptp_clock_info glue, including the kvmclock conversion if
needed. And *also* hook them in for setting the clock at startup, and
even calibrating CLOCK_REALTIME.

--=-dxATG9YWDDmi1QmA3I+b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD9Aw
ggSOMIIDdqADAgECAhAOmiw0ECVD4cWj5DqVrT9PMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yNDAxMzAwMDAwMDBaFw0zMTEx
MDkyMzU5NTlaMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYDVQQDExdWZXJv
a2V5IFNlY3VyZSBFbWFpbCBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMjvgLKj
jfhCFqxYyRiW8g3cNFAvltDbK5AzcOaR7yVzVGadr4YcCVxjKrEJOgi7WEOH8rUgCNB5cTD8N/Et
GfZI+LGqSv0YtNa54T9D1AWJy08ZKkWvfGGIXN9UFAPMJ6OLLH/UUEgFa+7KlrEvMUupDFGnnR06
aDJAwtycb8yXtILj+TvfhLFhafxroXrflspavejQkEiHjNjtHnwbZ+o43g0/yxjwnarGI3kgcak7
nnI9/8Lqpq79tLHYwLajotwLiGTB71AGN5xK+tzB+D4eN9lXayrjcszgbOv2ZCgzExQUAIt98mre
8EggKs9mwtEuKAhYBIP/0K6WsoMnQCcCAwEAAaOCAVwwggFYMBIGA1UdEwEB/wQIMAYBAf8CAQAw
HQYDVR0OBBYEFIlICOogTndrhuWByNfhjWSEf/xwMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
IZ3zbcgPMA4GA1UdDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIweQYI
KwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYB
BQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
QS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
QXNzdXJlZElEUm9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQELBQADggEB
ACiagCqvNVxOfSd0uYfJMiZsOEBXAKIR/kpqRp2YCfrP4Tz7fJogYN4fxNAw7iy/bPZcvpVCfe/H
/CCcp3alXL0I8M/rnEnRlv8ItY4MEF+2T/MkdXI3u1vHy3ua8SxBM8eT9LBQokHZxGUX51cE0kwa
uEOZ+PonVIOnMjuLp29kcNOVnzf8DGKiek+cT51FvGRjV6LbaxXOm2P47/aiaXrDD5O0RF5SiPo6
xD1/ClkCETyyEAE5LRJlXtx288R598koyFcwCSXijeVcRvBB1cNOLEbg7RMSw1AGq14fNe2cH1HG
W7xyduY/ydQt6gv5r21mDOQ5SaZSWC/ZRfLDuEYwggWbMIIEg6ADAgECAhAH5JEPagNRXYDiRPdl
c1vgMA0GCSqGSIb3DQEBCwUAMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYD
VQQDExdWZXJva2V5IFNlY3VyZSBFbWFpbCBHMjAeFw0yNDEyMzAwMDAwMDBaFw0yODAxMDQyMzU5
NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqGSIb3DQEBAQUAA4IC
DwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZeYAS/SRV6zmfXlXaZ
sNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2zkC9S7/yHDYnqegqt
w4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qGpgFdZEk2/c//ZvUN
i12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41vav1RhZJzYan4a1gU0
kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0cvnO8FM6PTqsnSbcc
0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PWPU6zfQTOMZ9uLQRR
ci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXtREF5lLXxp+CJ6KKS
blPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQrlR0gO3lBzuyPPArV
hvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7IqaAovAX0d+f1YjbmC
VsAwjhLmveFjNwIDAQABo4IBsDCCAawwHwYDVR0jBBgwFoAUiUgI6iBOd2uG5YHI1+GNZIR//HAw
HQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3bXcyQGluZnJhZGVh
ZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEBMA4GA1UdDwEB/wQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwewYDVR0fBHQwcjA3oDWgM4YxaHR0
cDovL2NybDMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDA3oDWgM4YxaHR0
cDovL2NybDQuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDB2BggrBgEFBQcB
AQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0
aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNydDANBgkq
hkiG9w0BAQsFAAOCAQEAQXc4FPiPLRnTDvmOABEzkIumojfZAe5SlnuQoeFUfi+LsWCKiB8Uextv
iBAvboKhLuN6eG/NC6WOzOCppn4mkQxRkOdLNThwMHW0d19jrZFEKtEG/epZ/hw/DdScTuZ2m7im
8ppItAT6GXD3aPhXkXnJpC/zTs85uNSQR64cEcBFjjoQDuSsTeJ5DAWf8EMyhMuD8pcbqx5kRvyt
JPsWBQzv1Dsdv2LDPLNd/JUKhHSgr7nbUr4+aAP2PHTXGcEBh8lTeYea9p4d5k969pe0OHYMV5aL
xERqTagmSetuIwolkAuBCzA9vulg8Y49Nz2zrpUGfKGOD0FMqenYxdJHgDCCBZswggSDoAMCAQIC
EAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQELBQAwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoT
B1Zlcm9rZXkxIDAeBgNVBAMTF1Zlcm9rZXkgU2VjdXJlIEVtYWlsIEcyMB4XDTI0MTIzMDAwMDAw
MFoXDTI4MDEwNDIzNTk1OVowHjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANqWLse95HW2F7FhfH9bugyT/danKmmXrbMnz5GZNAfj
Jl5gBL9JFXrOZ9eVdpmw04Tp6aDxZctFLoEDvSWKi367Q7Sg+ci+fH4KwwfQ8Pi0IpIKx2n5emEg
nbOQL1Lv/IcNiep6Cq3DiyaSpSp/RZf+CAfUNySHS8eWmhLU6jGpSD6hxTpYKye7PmrmvMWwfGEP
WoamAV1kSTb9z/9m9Q2LXa89aKmTxNwnAfD3Ohn9mtU3JukwILRMewn9QRXK7KzM+01h5hkCE4nj
W9q/VGFknNhqfhrWBTSQoE9CSVylASGrjzCgS7XmKy/BaH3/7mOOHQv5g1o3Qj/+cdKnpT0I5Qb1
nRy+c7wUzo9OqydJtxzSP4ZyHA4dELto/a3m/ay1XHcpum1pgTOLgxAfGb/T4dCkwRUstSKLMmpL
g9Y9TrN9BM4xn24tBFFyL5znGG0wQGzOVAM68RBzIQb6Fz758fjsr4yZnPbVsU1+gHEs/puNHrG0
9e1EQXmUtfGn4InoopJuU8p5VGD9S3Ikd4UoBlc7xl5yjtNlQxUeYrRlnUSmdlucCEoTX1n4UmtA
9CuVHSA7eUHO7I88CtWG9bGOU7tLgOZoSEvNqtaL/N7sQbBZK4jZ4Rr/zNTQg1SwYjjLB7u96lDP
sipoCi8BfR35/ViNuYJWwDCOEua94WM3AgMBAAGjggGwMIIBrDAfBgNVHSMEGDAWgBSJSAjqIE53
a4blgcjX4Y1khH/8cDAdBgNVHQ4EFgQUXGIam3Bs59Y60yTmWgfDu6pZQ6cwMAYDVR0RBCkwJ4ET
ZHdtdzJAaW5mcmFkZWFkLm9yZ4EQZGF2aWRAd29vZGhvdS5zZTAUBgNVHSAEDTALMAkGB2eBDAEF
AQEwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDB7BgNVHR8E
dDByMDegNaAzhjFodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMDegNaAzhjFodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMHYGCCsGAQUFBwEBBGowaDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEAGCCsGAQUFBzAChjRodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVt
YWlsRzIuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBBdzgU+I8tGdMO+Y4AETOQi6aiN9kB7lKWe5Ch
4VR+L4uxYIqIHxR7G2+IEC9ugqEu43p4b80LpY7M4KmmfiaRDFGQ50s1OHAwdbR3X2OtkUQq0Qb9
6ln+HD8N1JxO5nabuKbymki0BPoZcPdo+FeRecmkL/NOzzm41JBHrhwRwEWOOhAO5KxN4nkMBZ/w
QzKEy4PylxurHmRG/K0k+xYFDO/UOx2/YsM8s138lQqEdKCvudtSvj5oA/Y8dNcZwQGHyVN5h5r2
nh3mT3r2l7Q4dgxXlovERGpNqCZJ624jCiWQC4ELMD2+6WDxjj03PbOulQZ8oY4PQUyp6djF0keA
MYIDuzCCA7cCAQEwVTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMX
VmVyb2tleSBTZWN1cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJYIZIAWUDBAIBBQCg
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDExMjA4MDQ0
M1owLwYJKoZIhvcNAQkEMSIEIPuw1cKztAc9l7TFBJWjwF2Q3KnK0oPOf+ZdAHEqGo2EMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAVyMLS1RCcKo/
4P0cE6fBcSxRvOjUIOTPVygWXWobwW6u4rsVfp8ygaRznYr766l3/eyd5DXbptYEQsnXVEH4lt/G
Oo9DpzFzV331HRLPqYix/TEybHVNvRMDzo5HPvdkds6OZgx0Nuti/VR+84hE7cjJTPfHrZCahjI7
m9HRzAJv+KT7YR/HluvJYtUtEGCEXmKij8hr/byxDlUUU7O7HWwLeZVJNqAV3VGt7TEdAUsBjvjb
b7llumLjhR3uXCzC3etnFk4RIawY4sfBALouJsYlTJ5VEg2M6vJI8uJCHeFSru36TL0LVxq+9zFv
d6g1tAUHSNEsKJeBS9lShSvPJ5XwOiaZlXfUiECLATN4zwNxRDE81c0IIVREFQgLURNVw9gVectq
1HP8r1BkHoQ5txny2YBYmJ5ATFBRhEamC5fpMk10Ts29Nk5t7HW3uDsx0dGsMV3QDjdht6ZTe0jR
WbsIk4BC36NIhMqJ1kVFDwcaK/292w/clYojqXACGrziukG/165knF3yfkpEvIcooBtWNpovC8fS
psb1etjY/futDDlJBTwahIqnvBApY4GdoYNC+b0anCXX3hGJlr8carOFcOQ1tECa5byCW0Ti8x5f
+KKTDd2MJGNpQUOWL4qDQQKLoSKkotf3bI+cbO3BjXL/Qjrs+5Nd09JeJJ1w1WkAAAAAAAA=


--=-dxATG9YWDDmi1QmA3I+b--

