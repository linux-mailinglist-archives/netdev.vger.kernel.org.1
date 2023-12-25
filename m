Return-Path: <netdev+bounces-60182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CFF81DF97
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 10:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8C21F21DE3
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 09:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A321798A;
	Mon, 25 Dec 2023 09:56:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A442615AF4
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-306-WCM6dNnBMGW3qQ_7HAT4Qw-1; Mon, 25 Dec 2023 09:56:09 +0000
X-MC-Unique: WCM6dNnBMGW3qQ_7HAT4Qw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 25 Dec
 2023 09:55:47 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 25 Dec 2023 09:55:47 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>, "'David S . Miller'"
	<davem@davemloft.net>, "'kuba@kernel.org'" <kuba@kernel.org>
CC: "'eric.dumazet@gmail.com'" <eric.dumazet@gmail.com>,
	"'martin.lau@linux.dev'" <martin.lau@linux.dev>, 'Alexei Starovoitov'
	<ast@kernel.org>, 'Stephen Hemminger' <stephen@networkplumber.org>, "'Jens
 Axboe'" <axboe@kernel.dk>, 'Daniel Borkmann' <daniel@iogearbox.net>, "'Andrii
 Nakryiko'" <andrii@kernel.org>
Subject: [PATCH net-next 2/4] bpf: Use bpfptr_is_kernel() instead of checking
 the is_kernel member.
Thread-Topic: [PATCH net-next 2/4] bpf: Use bpfptr_is_kernel() instead of
 checking the is_kernel member.
Thread-Index: Ado3GDGG2wrg4MoTTqOrs9yxe27GgA==
Date: Mon, 25 Dec 2023 09:55:47 +0000
Message-ID: <96098101c3904e3d94c756fa9af392b4@AcuMS.aculab.com>
References: <199c9af56a5741feaf4b1768bf7356be@AcuMS.aculab.com>
In-Reply-To: <199c9af56a5741feaf4b1768bf7356be@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

In some places the bpf code directly access the is_kernel member of bpfptr_=
t.
Change to use the bpfptr_is_kernel() helper.

No functional change.

Signed-off-by: David Laight <david.laight@aculab.com>
---

I'm not at all sure that the pattern:
=09urecord =3D make_bpfptr(attr->func_info, bpfptr_is_kernel(uattr));
isn't bending the rules somewhat - but that is a different issue.

 kernel/bpf/bpf_iter.c |  2 +-
 kernel/bpf/btf.c      |  2 +-
 kernel/bpf/syscall.c  | 12 ++++++------
 kernel/bpf/verifier.c | 10 +++++-----
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 0fae79164187..eb2c858dbf81 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -520,7 +520,7 @@ int bpf_iter_link_attach(const union bpf_attr *attr, bp=
fptr_t uattr,
=20
 =09memset(&linfo, 0, sizeof(union bpf_iter_link_info));
=20
-=09ulinfo =3D make_bpfptr(attr->link_create.iter_info, uattr.is_kernel);
+=09ulinfo =3D make_bpfptr(attr->link_create.iter_info, bpfptr_is_kernel(ua=
ttr));
 =09linfo_len =3D attr->link_create.iter_info_len;
 =09if (bpfptr_is_null(ulinfo) ^ !linfo_len)
 =09=09return -EINVAL;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 15d71d2986d3..34720a1f586e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5483,7 +5483,7 @@ static int finalize_log(struct bpf_verifier_log *log,=
 bpfptr_t uattr, u32 uattr_
=20
 static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u=
32 uattr_size)
 {
-=09bpfptr_t btf_data =3D make_bpfptr(attr->btf, uattr.is_kernel);
+=09bpfptr_t btf_data =3D make_bpfptr(attr->btf, bpfptr_is_kernel(uattr));
 =09char __user *log_ubuf =3D u64_to_user_ptr(attr->btf_log_buf);
 =09struct btf_struct_metas *struct_meta_tab;
 =09struct btf_verifier_env *env =3D NULL;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0ed286b8a0f0..ba59fa8d02db 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -93,7 +93,7 @@ int bpf_check_uarg_tail_zero(bpfptr_t uaddr,
 =09if (actual_size <=3D expected_size)
 =09=09return 0;
=20
-=09if (uaddr.is_kernel)
+=09if (bpfptr_is_kernel(uaddr))
 =09=09res =3D memchr_inv(uaddr.kernel + expected_size, 0,
 =09=09=09=09 actual_size - expected_size) =3D=3D NULL;
 =09else
@@ -1482,8 +1482,8 @@ static int map_lookup_elem(union bpf_attr *attr)
=20
 static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 {
-=09bpfptr_t ukey =3D make_bpfptr(attr->key, uattr.is_kernel);
-=09bpfptr_t uvalue =3D make_bpfptr(attr->value, uattr.is_kernel);
+=09bpfptr_t ukey =3D make_bpfptr(attr->key, bpfptr_is_kernel(uattr));
+=09bpfptr_t uvalue =3D make_bpfptr(attr->value, bpfptr_is_kernel(uattr));
 =09int ufd =3D attr->map_fd;
 =09struct bpf_map *map;
 =09void *key, *value;
@@ -1538,7 +1538,7 @@ static int map_update_elem(union bpf_attr *attr, bpfp=
tr_t uattr)
=20
 static int map_delete_elem(union bpf_attr *attr, bpfptr_t uattr)
 {
-=09bpfptr_t ukey =3D make_bpfptr(attr->key, uattr.is_kernel);
+=09bpfptr_t ukey =3D make_bpfptr(attr->key, bpfptr_is_kernel(uattr));
 =09int ufd =3D attr->map_fd;
 =09struct bpf_map *map;
 =09struct fd f;
@@ -2670,12 +2670,12 @@ static int bpf_prog_load(union bpf_attr *attr, bpfp=
tr_t uattr, u32 uattr_size)
=20
 =09err =3D -EFAULT;
 =09if (copy_from_bpfptr(prog->insns,
-=09=09=09     make_bpfptr(attr->insns, uattr.is_kernel),
+=09=09=09     make_bpfptr(attr->insns, bpfptr_is_kernel(uattr)),
 =09=09=09     bpf_prog_insn_size(prog)) !=3D 0)
 =09=09goto free_prog_sec;
 =09/* copy eBPF program license from user space */
 =09if (strncpy_from_bpfptr(license,
-=09=09=09=09make_bpfptr(attr->license, uattr.is_kernel),
+=09=09=09=09make_bpfptr(attr->license, bpfptr_is_kernel(uattr)),
 =09=09=09=09sizeof(license) - 1) < 0)
 =09=09goto free_prog_sec;
 =09license[sizeof(license) - 1] =3D 0;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index af2819d5c8ee..42fea4966175 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15838,7 +15838,7 @@ static int check_btf_func_early(struct bpf_verifier=
_env *env,
 =09prog =3D env->prog;
 =09btf =3D prog->aux->btf;
=20
-=09urecord =3D make_bpfptr(attr->func_info, uattr.is_kernel);
+=09urecord =3D make_bpfptr(attr->func_info, bpfptr_is_kernel(uattr));
 =09min_size =3D min_t(u32, krec_size, urec_size);
=20
 =09krecord =3D kvcalloc(nfuncs, krec_size, GFP_KERNEL | __GFP_NOWARN);
@@ -15938,7 +15938,7 @@ static int check_btf_func(struct bpf_verifier_env *=
env,
 =09prog =3D env->prog;
 =09btf =3D prog->aux->btf;
=20
-=09urecord =3D make_bpfptr(attr->func_info, uattr.is_kernel);
+=09urecord =3D make_bpfptr(attr->func_info, bpfptr_is_kernel(uattr));
=20
 =09krecord =3D prog->aux->func_info;
 =09info_aux =3D kcalloc(nfuncs, sizeof(*info_aux), GFP_KERNEL | __GFP_NOWA=
RN);
@@ -16036,7 +16036,7 @@ static int check_btf_line(struct bpf_verifier_env *=
env,
=20
 =09s =3D 0;
 =09sub =3D env->subprog_info;
-=09ulinfo =3D make_bpfptr(attr->line_info, uattr.is_kernel);
+=09ulinfo =3D make_bpfptr(attr->line_info, bpfptr_is_kernel(uattr));
 =09expected_size =3D sizeof(struct bpf_line_info);
 =09ncopy =3D min_t(u32, expected_size, rec_size);
 =09for (i =3D 0; i < nr_linfo; i++) {
@@ -16154,7 +16154,7 @@ static int check_core_relo(struct bpf_verifier_env =
*env,
 =09    rec_size % sizeof(u32))
 =09=09return -EINVAL;
=20
-=09u_core_relo =3D make_bpfptr(attr->core_relos, uattr.is_kernel);
+=09u_core_relo =3D make_bpfptr(attr->core_relos, bpfptr_is_kernel(uattr));
 =09expected_size =3D sizeof(struct bpf_core_relo);
 =09ncopy =3D min_t(u32, expected_size, rec_size);
=20
@@ -20790,7 +20790,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_att=
r *attr, bpfptr_t uattr, __u3
 =09=09env->insn_aux_data[i].orig_idx =3D i;
 =09env->prog =3D *prog;
 =09env->ops =3D bpf_verifier_ops[env->prog->type];
-=09env->fd_array =3D make_bpfptr(attr->fd_array, uattr.is_kernel);
+=09env->fd_array =3D make_bpfptr(attr->fd_array, bpfptr_is_kernel(uattr));
 =09is_priv =3D bpf_capable();
=20
 =09bpf_get_btf_vmlinux();
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


