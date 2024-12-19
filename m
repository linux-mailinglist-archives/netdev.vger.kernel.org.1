Return-Path: <netdev+bounces-153154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B399F715E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 01:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E701890A02
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 00:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB0979F2;
	Thu, 19 Dec 2024 00:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzKL6ms4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D59FC147
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 00:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734568243; cv=none; b=la9YWvfrsIcKb2r7WXCNdLMhQWNPUjptgF9qYTcr8BfDcVshWUzuKiJ1bR8GC8UhAMNmPQ9aBRkdTZ81vvU/U4FymXDX5BNbrBDgNxO92jHVpVgTFo9Awjcn2SiXL4hxjqODf7WKR++zUWJBaYhRJ7BfNPXxBW8S1qCt54KAqgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734568243; c=relaxed/simple;
	bh=SzCqig/F4VZfTqqUgZhWE2D7IvNUfxFIUtQv3Z4WLvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1uTDinvGd/+hbxlOS8CyVl488DIxpt0Z4IJfwkxzqZtqO0ohKhsNDNdse7fIcXh4x44xO5+Vz+m93eBXriVfHGuupL5KDBo06W/fkwweCQ4qzt/oTt4Vp0k8S3n1ONYDOcRHITfCNUCromBfAPNMH6iTKaJfAYpWcG+U60Z5LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzKL6ms4; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-540254357c8so150176e87.1
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 16:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734568239; x=1735173039; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=idcN196X3UNCIajtXITEm/0E2usHLJb8dX1VwnnhfLU=;
        b=GzKL6ms4klWIY7gkOe4nwaAQ8aBFuE7pGhowXMKLw20ex4NzuI2DlpQzOOeL0Sig1L
         dN4dYZZI5y7wuIw8DFRI4/gC8lYHy9BVU57bw49HC4933DZIhI+OBzjkIZjcqO1Lgfu7
         Rdb9FMVkqM3SPmk5OPgHuSnR16INeOu2j4a69FpcQJHtTZd650nhFn9MkH1VSnlXyzCp
         Tx2VyatwtnijdJjixlFCEVQyu3g8XTmw3egnlGJDxThmYatviBQAXKhMDLMYPiUZ7+KZ
         Ljp1u3hJrHXZmhxQ2pyehdNgXQD2ns0+GL05VhG2hRw9GB5uF4o/hK1811cqzn2nWv6V
         3/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734568239; x=1735173039;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idcN196X3UNCIajtXITEm/0E2usHLJb8dX1VwnnhfLU=;
        b=FNJAH2CYe6H3NKRhSgq1RCx99jlg3Jl9JS00evXPPo8dbfi9+3DpPQPMBHXgw5dYWW
         XYbGkbYc8NJVzBzp4tt7xGs7Ot2jMHV244iG1m+qKBifQWQxqWnHuH7HewJGKVZP3yCg
         sbNWPbpJcSgaz1AuDqYpynNIrL9myEbl+Fy7ksc4GC9pfB/yYWmsmdjxDWsCNuWyokY4
         NbytSjsNMcU04r9YlnuJmdksZlJwRhefbYDMId23EURo1Rc1bjQxHI4XvGza/2jYscD2
         L9zV0/UDlWutW5qozQFbiR3YZvVgcjqDH8vJcBuUQ2rFkE6/HN5ek8lgQUjkbmUqZyYd
         9Zwg==
X-Gm-Message-State: AOJu0YxjeiBCcqElhzvWLE++oUqvakroKbfIjF44Q6sT8j8+/aNuETwr
	BOn+FBcPu9rCHIK0nw1iez/TpvcE8bHh3MZvi1TSXKMXG4h7Wi2Y0m62r0PcddOn5xbDFBhcsr5
	LX/ND19JVQlwVSZWNT5NE5fm1UwiRvg==
X-Gm-Gg: ASbGncudzIWjhJZAf2nV6ogytmDBioMzzducS/Kufuqq+bZs1RojPn/NxCFo3+0gM6T
	2ewy2uS5eECExZ0nzKsxY0aj1D9+NV+UV1G+vHKCUp/mvDINwtBwNziAke2C3pBjtY0E3ofs=
X-Google-Smtp-Source: AGHT+IGPjrb6UwxVsgvNB78bspcsNJ3S9nLBQvLd780Sb5394sp+uOK6rXxaEO9sLGmuk8f0JO+vgLNzuODftfxZ4lI=
X-Received: by 2002:a05:6512:3c86:b0:53e:2f9d:6a7b with SMTP id
 2adb3069b0e04-541e673be52mr1902236e87.10.1734568238986; Wed, 18 Dec 2024
 16:30:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5msqxcvHcbDt0x_eNpbdPxUhgFoOAPchZ16EBZeFhCdAKA@mail.gmail.com>
 <CAH2r5mtoz+4RSDLJijNFD6dRiLTWKou8m3M2mTp2cy7oPsP=Qg@mail.gmail.com>
In-Reply-To: <CAH2r5mtoz+4RSDLJijNFD6dRiLTWKou8m3M2mTp2cy7oPsP=Qg@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Wed, 18 Dec 2024 18:30:27 -0600
Message-ID: <CAH2r5ms9Q3D4FuNaZEaoXWMBiuwdus1GV5WFZVx14Ta1eJ5xNQ@mail.gmail.com>
Subject: Fwd: [PATCH][SMB3 client] fix TCP timers deadlock after rmmod
To: Network Development <netdev@vger.kernel.org>
Cc: Enzo Matsumiya <ematsumiya@suse.de>
Content-Type: multipart/mixed; boundary="000000000000b95436062994a312"

--000000000000b95436062994a312
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Correcting email for network mailing list

---------- Forwarded message ---------
From: Steve French <smfrench@gmail.com>
Date: Wed, Dec 18, 2024 at 6:28=E2=80=AFPM
Subject: Fwd: [PATCH][SMB3 client] fix TCP timers deadlock after rmmod
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
<linux-net@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Enzo Matsumiya <ematsumiya@suse.de>


Adding fsdevel and networking in case any thoughts on this fix for
network/namespaces refcount issue (that causes rmmod UAF).

Any opinions on Enzo's proposed Fix?

---------- Forwarded message ---------
From: Steve French <smfrench@gmail.com>
Date: Tue, Dec 17, 2024 at 9:24=E2=80=AFPM
Subject: [PATCH][SMB3 client] fix TCP timers deadlock after rmmod
To: CIFS <linux-cifs@vger.kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Enzo Matsumiya <ematsumiya@suse.=
de>


Enzo had an interesting patch, that seems to fix an important problem.

Here was his repro scenario:

     tw:~ # mount.cifs -o credentials=3D/root/wincreds,echo_interval=3D10
//someserver/target1 /mnt/test
     tw:~ # ls /mnt/test
     abc  dir1  dir3  target1_file.txt  tsub
     tw:~ # iptables -A INPUT -s someserver -j DROP

Trigger reconnect and wait for 3*echo_interval:

     tw:~ # cat /mnt/test/target1_file.txt
     cat: /mnt/test/target1_file.txt: Host is down

Then umount and rmmod.  Note that rmmod might take several iterations
until it properly tears down everything, so make sure you see the "not
loaded" message before proceeding:

     tw:~ # umount /mnt/*; rmmod cifs
     umount: /mnt/az: not mounted.
     umount: /mnt/dfs: not mounted.
     umount: /mnt/local: not mounted.
     umount: /mnt/scratch: not mounted.
     rmmod: ERROR: Module cifs is in use
     ...
     tw:~ # rmmod cifs
     rmmod: ERROR: Module cifs is not currently loaded

Then kickoff the TCP internals:
     tw:~ # iptables -F

Gets the lockdep warning (requires CONFIG_LOCKDEP=3Dy) + a NULL deref
later on.


Any thoughts on his patch?  See below (and attached)

    Commit ef7134c7fc48 ("smb: client: Fix use-after-free of network
namespace.")
    fixed a netns UAF by manually enabled socket refcounting
    (sk->sk_net_refcnt=3D1 and sock_inuse_add(net, 1)).

    The reason the patch worked for that bug was because we now hold
    references to the netns (get_net_track() gets a ref internally)
    and they're properly released (internally, on __sk_destruct()),
    but only because sk->sk_net_refcnt was set.

    Problem:
    (this happens regardless of CONFIG_NET_NS_REFCNT_TRACKER and regardless
    if init_net or other)

    Setting sk->sk_net_refcnt=3D1 *manually* and *after* socket creation is=
 not
    only out of cifs scope, but also technically wrong -- it's set conditio=
nally
    based on user (=3D1) vs kernel (=3D0) sockets.  And net/ implementation=
s
    seem to base their user vs kernel space operations on it.

    e.g. upon TCP socket close, the TCP timers are not cleared because
    sk->sk_net_refcnt=3D1:
    (cf. commit 151c9c724d05 ("tcp: properly terminate timers for
kernel sockets"))

    net/ipv4/tcp.c:
        void tcp_close(struct sock *sk, long timeout)
        {
            lock_sock(sk);
            __tcp_close(sk, timeout);
            release_sock(sk);
            if (!sk->sk_net_refcnt)
                    inet_csk_clear_xmit_timers_sync(sk);
            sock_put(sk);
        }

    Which will throw a lockdep warning and then, as expected, deadlock on
    tcp_write_timer().

    A way to reproduce this is by running the reproducer from ef7134c7fc48
    and then 'rmmod cifs'.  A few seconds later, the deadlock/lockdep
    warning shows up.

    Fix:
    We shouldn't mess with socket internals ourselves, so do not set
    sk_net_refcnt manually.

    Also change __sock_create() to sock_create_kern() for explicitness.

    As for non-init_net network namespaces, we deal with it the best way
    we can -- hold an extra netns reference for server->ssocket and drop it
    when it's released.  This ensures that the netns still exists whenever
    we need to create/destroy server->ssocket, but is not directly tied to
    it.

    Fixes: ef7134c7fc48 ("smb: client: Fix use-after-free of network
namespace.")


--
Thanks,

Steve


--
Thanks,

Steve


--=20
Thanks,

Steve

--000000000000b95436062994a312
Content-Type: application/x-patch; 
	name="0001-smb-client-fix-TCP-timers-deadlock-after-rmmod.patch"
Content-Disposition: attachment; 
	filename="0001-smb-client-fix-TCP-timers-deadlock-after-rmmod.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m4tbrgnr0>
X-Attachment-Id: f_m4tbrgnr0

RnJvbSBmNmNmYTRiYzI2MTQ3N2Y3YTkxYzQ2ZjM0YjhkMTYzZjE5ODcwMjQ5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbnpvIE1hdHN1bWl5YSA8ZW1hdHN1bWl5YUBzdXNlLmRlPgpE
YXRlOiBUdWUsIDEwIERlYyAyMDI0IDE4OjE1OjEyIC0wMzAwClN1YmplY3Q6IFtQQVRDSCAxLzRd
IHNtYjogY2xpZW50OiBmaXggVENQIHRpbWVycyBkZWFkbG9jayBhZnRlciBybW1vZAoKQ29tbWl0
IGVmNzEzNGM3ZmM0OCAoInNtYjogY2xpZW50OiBGaXggdXNlLWFmdGVyLWZyZWUgb2YgbmV0d29y
ayBuYW1lc3BhY2UuIikKZml4ZWQgYSBuZXRucyBVQUYgYnkgbWFudWFsbHkgZW5hYmxlZCBzb2Nr
ZXQgcmVmY291bnRpbmcKKHNrLT5za19uZXRfcmVmY250PTEgYW5kIHNvY2tfaW51c2VfYWRkKG5l
dCwgMSkpLgoKVGhlIHJlYXNvbiB0aGUgcGF0Y2ggd29ya2VkIGZvciB0aGF0IGJ1ZyB3YXMgYmVj
YXVzZSB3ZSBub3cgaG9sZApyZWZlcmVuY2VzIHRvIHRoZSBuZXRucyAoZ2V0X25ldF90cmFjaygp
IGdldHMgYSByZWYgaW50ZXJuYWxseSkKYW5kIHRoZXkncmUgcHJvcGVybHkgcmVsZWFzZWQgKGlu
dGVybmFsbHksIG9uIF9fc2tfZGVzdHJ1Y3QoKSksCmJ1dCBvbmx5IGJlY2F1c2Ugc2stPnNrX25l
dF9yZWZjbnQgd2FzIHNldC4KClByb2JsZW06Cih0aGlzIGhhcHBlbnMgcmVnYXJkbGVzcyBvZiBD
T05GSUdfTkVUX05TX1JFRkNOVF9UUkFDS0VSIGFuZCByZWdhcmRsZXNzCmlmIGluaXRfbmV0IG9y
IG90aGVyKQoKU2V0dGluZyBzay0+c2tfbmV0X3JlZmNudD0xICptYW51YWxseSogYW5kICphZnRl
ciogc29ja2V0IGNyZWF0aW9uIGlzIG5vdApvbmx5IG91dCBvZiBjaWZzIHNjb3BlLCBidXQgYWxz
byB0ZWNobmljYWxseSB3cm9uZyAtLSBpdCdzIHNldCBjb25kaXRpb25hbGx5CmJhc2VkIG9uIHVz
ZXIgKD0xKSB2cyBrZXJuZWwgKD0wKSBzb2NrZXRzLiAgQW5kIG5ldC8gaW1wbGVtZW50YXRpb25z
CnNlZW0gdG8gYmFzZSB0aGVpciB1c2VyIHZzIGtlcm5lbCBzcGFjZSBvcGVyYXRpb25zIG9uIGl0
LgoKZS5nLiB1cG9uIFRDUCBzb2NrZXQgY2xvc2UsIHRoZSBUQ1AgdGltZXJzIGFyZSBub3QgY2xl
YXJlZCBiZWNhdXNlCnNrLT5za19uZXRfcmVmY250PTE6CihjZi4gY29tbWl0IDE1MWM5YzcyNGQw
NSAoInRjcDogcHJvcGVybHkgdGVybWluYXRlIHRpbWVycyBmb3Iga2VybmVsIHNvY2tldHMiKSkK
Cm5ldC9pcHY0L3RjcC5jOgogICAgdm9pZCB0Y3BfY2xvc2Uoc3RydWN0IHNvY2sgKnNrLCBsb25n
IHRpbWVvdXQpCiAgICB7CiAgICAJbG9ja19zb2NrKHNrKTsKICAgIAlfX3RjcF9jbG9zZShzaywg
dGltZW91dCk7CiAgICAJcmVsZWFzZV9zb2NrKHNrKTsKICAgIAlpZiAoIXNrLT5za19uZXRfcmVm
Y250KQogICAgCQlpbmV0X2Nza19jbGVhcl94bWl0X3RpbWVyc19zeW5jKHNrKTsKICAgIAlzb2Nr
X3B1dChzayk7CiAgICB9CgpXaGljaCB3aWxsIHRocm93IGEgbG9ja2RlcCB3YXJuaW5nIGFuZCB0
aGVuLCBhcyBleHBlY3RlZCwgZGVhZGxvY2sgb24KdGNwX3dyaXRlX3RpbWVyKCkuCgpBIHdheSB0
byByZXByb2R1Y2UgdGhpcyBpcyBieSBydW5uaW5nIHRoZSByZXByb2R1Y2VyIGZyb20gZWY3MTM0
YzdmYzQ4CmFuZCB0aGVuICdybW1vZCBjaWZzJy4gIEEgZmV3IHNlY29uZHMgbGF0ZXIsIHRoZSBk
ZWFkbG9jay9sb2NrZGVwCndhcm5pbmcgc2hvd3MgdXAuCgpGaXg6CldlIHNob3VsZG4ndCBtZXNz
IHdpdGggc29ja2V0IGludGVybmFscyBvdXJzZWx2ZXMsIHNvIGRvIG5vdCBzZXQKc2tfbmV0X3Jl
ZmNudCBtYW51YWxseS4KCkFsc28gY2hhbmdlIF9fc29ja19jcmVhdGUoKSB0byBzb2NrX2NyZWF0
ZV9rZXJuKCkgZm9yIGV4cGxpY2l0bmVzcy4KCkFzIGZvciBub24taW5pdF9uZXQgbmV0d29yayBu
YW1lc3BhY2VzLCB3ZSBkZWFsIHdpdGggaXQgdGhlIGJlc3Qgd2F5CndlIGNhbiAtLSBob2xkIGFu
IGV4dHJhIG5ldG5zIHJlZmVyZW5jZSBmb3Igc2VydmVyLT5zc29ja2V0IGFuZCBkcm9wIGl0Cndo
ZW4gaXQncyByZWxlYXNlZC4gIFRoaXMgZW5zdXJlcyB0aGF0IHRoZSBuZXRucyBzdGlsbCBleGlz
dHMgd2hlbmV2ZXIKd2UgbmVlZCB0byBjcmVhdGUvZGVzdHJveSBzZXJ2ZXItPnNzb2NrZXQsIGJ1
dCBpcyBub3QgZGlyZWN0bHkgdGllZCB0bwppdC4KCkZpeGVzOiBlZjcxMzRjN2ZjNDggKCJzbWI6
IGNsaWVudDogRml4IHVzZS1hZnRlci1mcmVlIG9mIG5ldHdvcmsgbmFtZXNwYWNlLiIpClNpZ25l
ZC1vZmYtYnk6IEVuem8gTWF0c3VtaXlhIDxlbWF0c3VtaXlhQHN1c2UuZGU+ClNpZ25lZC1vZmYt
Ynk6IFN0ZXZlIEZyZW5jaCA8c3RmcmVuY2hAbWljcm9zb2Z0LmNvbT4KLS0tCiBmcy9zbWIvY2xp
ZW50L2Nvbm5lY3QuYyB8IDM2ICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2ZzL3NtYi9jbGllbnQvY29ubmVjdC5jIGIvZnMvc21iL2NsaWVudC9jb25uZWN0LmMK
aW5kZXggMjM3MjUzOGExMjExLi5kZGNjOWU1MTRhMGUgMTAwNjQ0Ci0tLSBhL2ZzL3NtYi9jbGll
bnQvY29ubmVjdC5jCisrKyBiL2ZzL3NtYi9jbGllbnQvY29ubmVjdC5jCkBAIC05ODcsOSArOTg3
LDEzIEBAIGNsZWFuX2RlbXVsdGlwbGV4X2luZm8oc3RydWN0IFRDUF9TZXJ2ZXJfSW5mbyAqc2Vy
dmVyKQogCW1zbGVlcCgxMjUpOwogCWlmIChjaWZzX3JkbWFfZW5hYmxlZChzZXJ2ZXIpKQogCQlz
bWJkX2Rlc3Ryb3koc2VydmVyKTsKKwogCWlmIChzZXJ2ZXItPnNzb2NrZXQpIHsKIAkJc29ja19y
ZWxlYXNlKHNlcnZlci0+c3NvY2tldCk7CiAJCXNlcnZlci0+c3NvY2tldCA9IE5VTEw7CisKKwkJ
LyogUmVsZWFzZSBuZXRucyByZWZlcmVuY2UgZm9yIHRoZSBzb2NrZXQuICovCisJCXB1dF9uZXQo
Y2lmc19uZXRfbnMoc2VydmVyKSk7CiAJfQogCiAJaWYgKCFsaXN0X2VtcHR5KCZzZXJ2ZXItPnBl
bmRpbmdfbWlkX3EpKSB7CkBAIC0xMDM3LDYgKzEwNDEsNyBAQCBjbGVhbl9kZW11bHRpcGxleF9p
bmZvKHN0cnVjdCBUQ1BfU2VydmVyX0luZm8gKnNlcnZlcikKIAkJICovCiAJfQogCisJLyogUmVs
ZWFzZSBuZXRucyByZWZlcmVuY2UgZm9yIHRoaXMgc2VydmVyLiAqLwogCXB1dF9uZXQoY2lmc19u
ZXRfbnMoc2VydmVyKSk7CiAJa2ZyZWUoc2VydmVyLT5sZWFmX2Z1bGxwYXRoKTsKIAlrZnJlZShz
ZXJ2ZXIpOwpAQCAtMTcxMyw2ICsxNzE4LDggQEAgY2lmc19nZXRfdGNwX3Nlc3Npb24oc3RydWN0
IHNtYjNfZnNfY29udGV4dCAqY3R4LAogCiAJdGNwX3Nlcy0+b3BzID0gY3R4LT5vcHM7CiAJdGNw
X3Nlcy0+dmFscyA9IGN0eC0+dmFsczsKKworCS8qIEdyYWIgbmV0bnMgcmVmZXJlbmNlIGZvciB0
aGlzIHNlcnZlci4gKi8KIAljaWZzX3NldF9uZXRfbnModGNwX3NlcywgZ2V0X25ldChjdXJyZW50
LT5uc3Byb3h5LT5uZXRfbnMpKTsKIAogCXRjcF9zZXMtPmNvbm5faWQgPSBhdG9taWNfaW5jX3Jl
dHVybigmdGNwU2VzTmV4dElkKTsKQEAgLTE4NDQsNiArMTg1MSw3IEBAIGNpZnNfZ2V0X3RjcF9z
ZXNzaW9uKHN0cnVjdCBzbWIzX2ZzX2NvbnRleHQgKmN0eCwKIG91dF9lcnJfY3J5cHRvX3JlbGVh
c2U6CiAJY2lmc19jcnlwdG9fc2VjbWVjaF9yZWxlYXNlKHRjcF9zZXMpOwogCisJLyogUmVsZWFz
ZSBuZXRucyByZWZlcmVuY2UgZm9yIHRoaXMgc2VydmVyLiAqLwogCXB1dF9uZXQoY2lmc19uZXRf
bnModGNwX3NlcykpOwogCiBvdXRfZXJyOgpAQCAtMTg1Miw4ICsxODYwLDEwIEBAIGNpZnNfZ2V0
X3RjcF9zZXNzaW9uKHN0cnVjdCBzbWIzX2ZzX2NvbnRleHQgKmN0eCwKIAkJCWNpZnNfcHV0X3Rj
cF9zZXNzaW9uKHRjcF9zZXMtPnByaW1hcnlfc2VydmVyLCBmYWxzZSk7CiAJCWtmcmVlKHRjcF9z
ZXMtPmhvc3RuYW1lKTsKIAkJa2ZyZWUodGNwX3Nlcy0+bGVhZl9mdWxscGF0aCk7Ci0JCWlmICh0
Y3Bfc2VzLT5zc29ja2V0KQorCQlpZiAodGNwX3Nlcy0+c3NvY2tldCkgewogCQkJc29ja19yZWxl
YXNlKHRjcF9zZXMtPnNzb2NrZXQpOworCQkJcHV0X25ldChjaWZzX25ldF9ucyh0Y3Bfc2VzKSk7
CisJCX0KIAkJa2ZyZWUodGNwX3Nlcyk7CiAJfQogCXJldHVybiBFUlJfUFRSKHJjKTsKQEAgLTMx
MzEsMjAgKzMxNDEsMjAgQEAgZ2VuZXJpY19pcF9jb25uZWN0KHN0cnVjdCBUQ1BfU2VydmVyX0lu
Zm8gKnNlcnZlcikKIAkJc29ja2V0ID0gc2VydmVyLT5zc29ja2V0OwogCX0gZWxzZSB7CiAJCXN0
cnVjdCBuZXQgKm5ldCA9IGNpZnNfbmV0X25zKHNlcnZlcik7Ci0JCXN0cnVjdCBzb2NrICpzazsK
IAotCQlyYyA9IF9fc29ja19jcmVhdGUobmV0LCBzZmFtaWx5LCBTT0NLX1NUUkVBTSwKLQkJCQkg
ICBJUFBST1RPX1RDUCwgJnNlcnZlci0+c3NvY2tldCwgMSk7CisJCXJjID0gc29ja19jcmVhdGVf
a2VybihuZXQsIHNmYW1pbHksIFNPQ0tfU1RSRUFNLCBJUFBST1RPX1RDUCwgJnNlcnZlci0+c3Nv
Y2tldCk7CiAJCWlmIChyYyA8IDApIHsKIAkJCWNpZnNfc2VydmVyX2RiZyhWRlMsICJFcnJvciAl
ZCBjcmVhdGluZyBzb2NrZXRcbiIsIHJjKTsKIAkJCXJldHVybiByYzsKIAkJfQogCi0JCXNrID0g
c2VydmVyLT5zc29ja2V0LT5zazsKLQkJX19uZXRuc190cmFja2VyX2ZyZWUobmV0LCAmc2stPm5z
X3RyYWNrZXIsIGZhbHNlKTsKLQkJc2stPnNrX25ldF9yZWZjbnQgPSAxOwotCQlnZXRfbmV0X3Ry
YWNrKG5ldCwgJnNrLT5uc190cmFja2VyLCBHRlBfS0VSTkVMKTsKLQkJc29ja19pbnVzZV9hZGQo
bmV0LCAxKTsKKwkJLyoKKwkJICogR3JhYiBuZXRucyByZWZlcmVuY2UgZm9yIHRoZSBzb2NrZXQu
CisJCSAqCisJCSAqIEl0J2xsIGJlIHJlbGVhc2VkIGhlcmUsIG9uIGVycm9yLCBvciBpbiBjbGVh
bl9kZW11bHRpcGxleF9pbmZvKCkgdXBvbiBzZXJ2ZXIKKwkJICogdGVhcmRvd24uCisJCSAqLwor
CQlnZXRfbmV0KG5ldCk7CiAKIAkJLyogQkIgb3RoZXIgc29ja2V0IG9wdGlvbnMgdG8gc2V0IEtF
RVBBTElWRSwgTk9ERUxBWT8gKi8KIAkJY2lmc19kYmcoRllJLCAiU29ja2V0IGNyZWF0ZWRcbiIp
OwpAQCAtMzE1OCw4ICszMTY4LDEwIEBAIGdlbmVyaWNfaXBfY29ubmVjdChzdHJ1Y3QgVENQX1Nl
cnZlcl9JbmZvICpzZXJ2ZXIpCiAJfQogCiAJcmMgPSBiaW5kX3NvY2tldChzZXJ2ZXIpOwotCWlm
IChyYyA8IDApCisJaWYgKHJjIDwgMCkgeworCQlwdXRfbmV0KGNpZnNfbmV0X25zKHNlcnZlcikp
OwogCQlyZXR1cm4gcmM7CisJfQogCiAJLyoKIAkgKiBFdmVudHVhbGx5IGNoZWNrIGZvciBvdGhl
ciBzb2NrZXQgb3B0aW9ucyB0byBjaGFuZ2UgZnJvbQpAQCAtMzE5Niw2ICszMjA4LDcgQEAgZ2Vu
ZXJpY19pcF9jb25uZWN0KHN0cnVjdCBUQ1BfU2VydmVyX0luZm8gKnNlcnZlcikKIAlpZiAocmMg
PCAwKSB7CiAJCWNpZnNfZGJnKEZZSSwgIkVycm9yICVkIGNvbm5lY3RpbmcgdG8gc2VydmVyXG4i
LCByYyk7CiAJCXRyYWNlX3NtYjNfY29ubmVjdF9lcnIoc2VydmVyLT5ob3N0bmFtZSwgc2VydmVy
LT5jb25uX2lkLCAmc2VydmVyLT5kc3RhZGRyLCByYyk7CisJCXB1dF9uZXQoY2lmc19uZXRfbnMo
c2VydmVyKSk7CiAJCXNvY2tfcmVsZWFzZShzb2NrZXQpOwogCQlzZXJ2ZXItPnNzb2NrZXQgPSBO
VUxMOwogCQlyZXR1cm4gcmM7CkBAIC0zMjA0LDYgKzMyMTcsOSBAQCBnZW5lcmljX2lwX2Nvbm5l
Y3Qoc3RydWN0IFRDUF9TZXJ2ZXJfSW5mbyAqc2VydmVyKQogCWlmIChzcG9ydCA9PSBodG9ucyhS
RkMxMDAxX1BPUlQpKQogCQlyYyA9IGlwX3JmYzEwMDFfY29ubmVjdChzZXJ2ZXIpOwogCisJaWYg
KHJjIDwgMCkKKwkJcHV0X25ldChjaWZzX25ldF9ucyhzZXJ2ZXIpKTsKKwogCXJldHVybiByYzsK
IH0KIAotLSAKMi40My4wCgo=
--000000000000b95436062994a312--

