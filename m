Return-Path: <netdev+bounces-144040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A30F29C533F
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 11:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23ACF1F21737
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 10:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA88F213148;
	Tue, 12 Nov 2024 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XWAfakZk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA5020B20B
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407056; cv=none; b=HhGQ3kfowYb2DqehxBWIsnKXHCxtSKuJhi3Km8UPfYbuDSk3de07bhD0/J5EeZ969xjiagcYLdTM+vDX8xEG4muTjj9ELh14nVZRh+G/dmgY3J710yGYORWKI10RVSHi1O0p9rko3b0ibsmR5L2ArcyfbzROUWXL1rMIkUc989A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407056; c=relaxed/simple;
	bh=HQ+4hiJo2e43jAbiT4zP8ykwJIojCxJabOYbcAy2PCs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VoufqqD7E2hC17cf8ww+VRrcf175L+hlQC4gjv6IkZtWjlRVjlricia8+D/FZX9ADvRqyJNmsWrMLH7hW3jVcYrGHd2YGl2hEEPbCJn+mspa9DqslF+nvSfy0tqS3jUA4yFStFHw5XzXtr2iTtzXgSK83akfPTX+Ro4Pp7D7K14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XWAfakZk; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb498a92f6so45590421fa.1
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 02:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731407053; x=1732011853; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zyBj5x3MbOOttifR6bDsiZwhI9ZY27KLTQDkVGljWsQ=;
        b=XWAfakZktwKMU1ncj/S2WCm6jVSfnG8TLJHgjszTmsq0SrspL6dnIP+jOi+JdOMlMt
         hQ1RqCBtDBEgDLqbO4k/mMqkF2Ue5PCRlt9xLdVluy3HLkDZmKBxT9L5qFJbho1Yg3J2
         uHeS6bhCV0S/Q0D2xlZQ0pqMatDNDo4LcCer7iQ4FjsEepIRwykIE+tQZi6yaYcf1JuF
         Yjm6Tsy7YOXA48gUgKMjBzNrY31y/FBPjq1TuLYeyQifs6N55azK3k/zavY2GYswqVXP
         hnEQ6DEUijhwn6iwCaiwj/5bjeySCqIrDBIzNYbfGZ0CGYnfg1PLllo4H+Vh4yc/txam
         k7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731407053; x=1732011853;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zyBj5x3MbOOttifR6bDsiZwhI9ZY27KLTQDkVGljWsQ=;
        b=KnTU/N1wZn75i2IDBALskf6R17ldf6MLCjYieulugT4ccd6rVyNgkf6kCll8EYTUx4
         JWCrks+++NF2+Tb+69gWtS1Q+gDOnSquiF885v/absGXkXmV/G6Vei8PB0h/QjF3Q15I
         rFEDQAhlc9SzP3hIEGCObF8N4slpHnF6vBP0mYU2CTnmPgXV18xP5RWBdT4WshqEnC5j
         uQyvGqiwOgSrdMxIGyAkTX9dgjCofkiui4hPsTuPJV8H9VItrIKKM6mUiKUAKpBM+zDS
         rDvo+Z8AGCoca4sB8bUnKxOE99IztpetrG9lFmJjf5c6NSjpdZ2ScVpxJtkOjprqVtKr
         xbtw==
X-Forwarded-Encrypted: i=1; AJvYcCXnEkg+qdKq2s/bWYlStZjjYwUGI3uuR2fXZjCJ+VPAiPAXzLCCU/ho7oG21MjRYvPg/CV4PEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmRBzSgPmoMQgIrLIMyH0Ycen/QXW40W5v/ddtwUu24ZYlU5np
	TrznOdnL+6a4CFf70qCrlyo8sZGNROKUAAVxUBNEplu5zmczoIEMRVwl/pgyxIg=
X-Google-Smtp-Source: AGHT+IGwUzNsrAZ8BgAC1m2+BBLzbg3tQTwaVaQaq5ksPgVrHj3qqXMGQXKxyjpzTTkz3arVFob4Jw==
X-Received: by 2002:a2e:a90a:0:b0:2ef:17f7:6e1d with SMTP id 38308e7fff4ca-2ff201e74b6mr76118211fa.4.1731407052370;
        Tue, 12 Nov 2024 02:24:12 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03b5d77csm5776079a12.5.2024.11.12.02.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 02:24:11 -0800 (PST)
Date: Tue, 12 Nov 2024 13:24:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: [bug report] xfrm: Cache used outbound xfrm states at the policy.
Message-ID: <d8659bc6-d8a7-4fc4-9b6b-39c80b24a9c8@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Steffen Klassert,

Commit 0045e3d80613 ("xfrm: Cache used outbound xfrm states at the
policy.") from Oct 23, 2024 (linux-next), leads to the following
Smatch static checker warning:

	net/xfrm/xfrm_state.c:1473 xfrm_state_find()
	error: uninitialized symbol 'h'.

net/xfrm/xfrm_state.c
    1260 struct xfrm_state *
    1261 xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
    1262                 const struct flowi *fl, struct xfrm_tmpl *tmpl,
    1263                 struct xfrm_policy *pol, int *err,
    1264                 unsigned short family, u32 if_id)
    1265 {
    1266         static xfrm_address_t saddr_wildcard = { };
    1267         struct net *net = xp_net(pol);
    1268         unsigned int h, h_wildcard;
    1269         struct xfrm_state *x, *x0, *to_put;
    1270         int acquire_in_progress = 0;
    1271         int error = 0;
    1272         struct xfrm_state *best = NULL;
    1273         u32 mark = pol->mark.v & pol->mark.m;
    1274         unsigned short encap_family = tmpl->encap_family;
    1275         unsigned int sequence;
    1276         struct km_event c;
    1277         unsigned int pcpu_id;
    1278         bool cached = false;
    1279 
    1280         /* We need the cpu id just as a lookup key,
    1281          * we don't require it to be stable.
    1282          */
    1283         pcpu_id = get_cpu();
    1284         put_cpu();
    1285 
    1286         to_put = NULL;
    1287 
    1288         sequence = read_seqcount_begin(&net->xfrm.xfrm_state_hash_generation);
    1289 
    1290         rcu_read_lock();
    1291         hlist_for_each_entry_rcu(x, &pol->state_cache_list, state_cache) {
    1292                 if (x->props.family == encap_family &&
    1293                     x->props.reqid == tmpl->reqid &&
    1294                     (mark & x->mark.m) == x->mark.v &&
    1295                     x->if_id == if_id &&
    1296                     !(x->props.flags & XFRM_STATE_WILDRECV) &&
    1297                     xfrm_state_addr_check(x, daddr, saddr, encap_family) &&
    1298                     tmpl->mode == x->props.mode &&
    1299                     tmpl->id.proto == x->id.proto &&
    1300                     (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
    1301                         xfrm_state_look_at(pol, x, fl, encap_family,
    1302                                            &best, &acquire_in_progress, &error);
    1303         }
    1304 
    1305         if (best)
    1306                 goto cached;

best is true.  "x" is NULL, error is zero.  I don't know about
acquire_in_progress.

    1307 
    1308         hlist_for_each_entry_rcu(x, &pol->state_cache_list, state_cache) {
    1309                 if (x->props.family == encap_family &&
    1310                     x->props.reqid == tmpl->reqid &&
    1311                     (mark & x->mark.m) == x->mark.v &&
    1312                     x->if_id == if_id &&
    1313                     !(x->props.flags & XFRM_STATE_WILDRECV) &&
    1314                     xfrm_addr_equal(&x->id.daddr, daddr, encap_family) &&
    1315                     tmpl->mode == x->props.mode &&
    1316                     tmpl->id.proto == x->id.proto &&
    1317                     (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
    1318                         xfrm_state_look_at(pol, x, fl, family,
    1319                                            &best, &acquire_in_progress, &error);
    1320         }
    1321 
    1322 cached:
    1323         cached = true;
    1324         if (best)
    1325                 goto found;

We goto found.

    1326         else if (error)
    1327                 best = NULL;
    1328         else if (acquire_in_progress) /* XXX: acquire_in_progress should not happen */
    1329                 WARN_ON(1);
    1330 
    1331         h = xfrm_dst_hash(net, daddr, saddr, tmpl->reqid, encap_family);
    1332         hlist_for_each_entry_rcu(x, net->xfrm.state_bydst + h, bydst) {
    1333 #ifdef CONFIG_XFRM_OFFLOAD
    1334                 if (pol->xdo.type == XFRM_DEV_OFFLOAD_PACKET) {
    1335                         if (x->xso.type != XFRM_DEV_OFFLOAD_PACKET)
    1336                                 /* HW states are in the head of list, there is
    1337                                  * no need to iterate further.
    1338                                  */
    1339                                 break;
    1340 
    1341                         /* Packet offload: both policy and SA should
    1342                          * have same device.
    1343                          */
    1344                         if (pol->xdo.dev != x->xso.dev)
    1345                                 continue;
    1346                 } else if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET)
    1347                         /* Skip HW policy for SW lookups */
    1348                         continue;
    1349 #endif
    1350                 if (x->props.family == encap_family &&
    1351                     x->props.reqid == tmpl->reqid &&
    1352                     (mark & x->mark.m) == x->mark.v &&
    1353                     x->if_id == if_id &&
    1354                     !(x->props.flags & XFRM_STATE_WILDRECV) &&
    1355                     xfrm_state_addr_check(x, daddr, saddr, encap_family) &&
    1356                     tmpl->mode == x->props.mode &&
    1357                     tmpl->id.proto == x->id.proto &&
    1358                     (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
    1359                         xfrm_state_look_at(pol, x, fl, family,
    1360                                            &best, &acquire_in_progress, &error);
    1361         }
    1362         if (best || acquire_in_progress)
    1363                 goto found;
    1364 
    1365         h_wildcard = xfrm_dst_hash(net, daddr, &saddr_wildcard, tmpl->reqid, encap_family);
    1366         hlist_for_each_entry_rcu(x, net->xfrm.state_bydst + h_wildcard, bydst) {
    1367 #ifdef CONFIG_XFRM_OFFLOAD
    1368                 if (pol->xdo.type == XFRM_DEV_OFFLOAD_PACKET) {
    1369                         if (x->xso.type != XFRM_DEV_OFFLOAD_PACKET)
    1370                                 /* HW states are in the head of list, there is
    1371                                  * no need to iterate further.
    1372                                  */
    1373                                 break;
    1374 
    1375                         /* Packet offload: both policy and SA should
    1376                          * have same device.
    1377                          */
    1378                         if (pol->xdo.dev != x->xso.dev)
    1379                                 continue;
    1380                 } else if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET)
    1381                         /* Skip HW policy for SW lookups */
    1382                         continue;
    1383 #endif
    1384                 if (x->props.family == encap_family &&
    1385                     x->props.reqid == tmpl->reqid &&
    1386                     (mark & x->mark.m) == x->mark.v &&
    1387                     x->if_id == if_id &&
    1388                     !(x->props.flags & XFRM_STATE_WILDRECV) &&
    1389                     xfrm_addr_equal(&x->id.daddr, daddr, encap_family) &&
    1390                     tmpl->mode == x->props.mode &&
    1391                     tmpl->id.proto == x->id.proto &&
    1392                     (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
    1393                         xfrm_state_look_at(pol, x, fl, family,
    1394                                            &best, &acquire_in_progress, &error);
    1395         }
    1396 
    1397 found:
    1398         if (!(pol->flags & XFRM_POLICY_CPU_ACQUIRE) ||
    1399             (best && (best->pcpu_num == pcpu_id)))
    1400                 x = best;
    1401 
    1402         if (!x && !error && !acquire_in_progress) {

These requirements are mostly met.  I don't know about acquire_in_progress.

    1403                 if (tmpl->id.spi &&
    1404                     (x0 = __xfrm_state_lookup_all(net, mark, daddr,
    1405                                                   tmpl->id.spi, tmpl->id.proto,
    1406                                                   encap_family,
    1407                                                   &pol->xdo)) != NULL) {
    1408                         to_put = x0;
    1409                         error = -EEXIST;
    1410                         goto out;
    1411                 }
    1412 
    1413                 c.net = net;
    1414                 /* If the KMs have no listeners (yet...), avoid allocating an SA
    1415                  * for each and every packet - garbage collection might not
    1416                  * handle the flood.
    1417                  */
    1418                 if (!km_is_alive(&c)) {
    1419                         error = -ESRCH;
    1420                         goto out;
    1421                 }
    1422 
    1423                 x = xfrm_state_alloc(net);
    1424                 if (x == NULL) {
    1425                         error = -ENOMEM;
    1426                         goto out;
    1427                 }
    1428                 /* Initialize temporary state matching only
    1429                  * to current session. */
    1430                 xfrm_init_tempstate(x, fl, tmpl, daddr, saddr, family);
    1431                 memcpy(&x->mark, &pol->mark, sizeof(x->mark));
    1432                 x->if_id = if_id;
    1433                 if ((pol->flags & XFRM_POLICY_CPU_ACQUIRE) && best)
    1434                         x->pcpu_num = pcpu_id;
    1435 
    1436                 error = security_xfrm_state_alloc_acquire(x, pol->security, fl->flowi_secid);
    1437                 if (error) {
    1438                         x->km.state = XFRM_STATE_DEAD;
    1439                         to_put = x;
    1440                         x = NULL;
    1441                         goto out;
    1442                 }
    1443 #ifdef CONFIG_XFRM_OFFLOAD
    1444                 if (pol->xdo.type == XFRM_DEV_OFFLOAD_PACKET) {
    1445                         struct xfrm_dev_offload *xdo = &pol->xdo;
    1446                         struct xfrm_dev_offload *xso = &x->xso;
    1447 
    1448                         xso->type = XFRM_DEV_OFFLOAD_PACKET;
    1449                         xso->dir = xdo->dir;
    1450                         xso->dev = xdo->dev;
    1451                         xso->real_dev = xdo->real_dev;
    1452                         xso->flags = XFRM_DEV_OFFLOAD_FLAG_ACQ;
    1453                         netdev_hold(xso->dev, &xso->dev_tracker, GFP_ATOMIC);
    1454                         error = xso->dev->xfrmdev_ops->xdo_dev_state_add(x, NULL);
    1455                         if (error) {
    1456                                 xso->dir = 0;
    1457                                 netdev_put(xso->dev, &xso->dev_tracker);
    1458                                 xso->dev = NULL;
    1459                                 xso->real_dev = NULL;
    1460                                 xso->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
    1461                                 x->km.state = XFRM_STATE_DEAD;
    1462                                 to_put = x;
    1463                                 x = NULL;
    1464                                 goto out;
    1465                         }
    1466                 }
    1467 #endif
    1468                 if (km_query(x, tmpl, pol) == 0) {
    1469                         spin_lock_bh(&net->xfrm.xfrm_state_lock);
    1470                         x->km.state = XFRM_STATE_ACQ;
    1471                         x->dir = XFRM_SA_DIR_OUT;
    1472                         list_add(&x->km.all, &net->xfrm.state_all);
--> 1473                         XFRM_STATE_INSERT(bydst, &x->bydst,
    1474                                           net->xfrm.state_bydst + h,
                                                                           ^
Potentially uninitialized?

    1475                                           x->xso.type);
    1476                         h = xfrm_src_hash(net, daddr, saddr, encap_family);
    1477                         XFRM_STATE_INSERT(bysrc, &x->bysrc,
    1478                                           net->xfrm.state_bysrc + h,
    1479                                           x->xso.type);
    1480                         INIT_HLIST_NODE(&x->state_cache);
    1481                         if (x->id.spi) {
    1482                                 h = xfrm_spi_hash(net, &x->id.daddr, x->id.spi, x->id.proto, encap_family);
    1483                                 XFRM_STATE_INSERT(byspi, &x->byspi,
    1484                                                   net->xfrm.state_byspi + h,
    1485                                                   x->xso.type);
    1486                         }
    1487                         if (x->km.seq) {
    1488                                 h = xfrm_seq_hash(net, x->km.seq);
    1489                                 XFRM_STATE_INSERT(byseq, &x->byseq,
    1490                                                   net->xfrm.state_byseq + h,
    1491                                                   x->xso.type);
    1492                         }
    1493                         x->lft.hard_add_expires_seconds = net->xfrm.sysctl_acq_expires;
    1494                         hrtimer_start(&x->mtimer,
    1495                                       ktime_set(net->xfrm.sysctl_acq_expires, 0),
    1496                                       HRTIMER_MODE_REL_SOFT);
    1497                         net->xfrm.state_num++;
    1498                         xfrm_hash_grow_check(net, x->bydst.next != NULL);
    1499                         spin_unlock_bh(&net->xfrm.xfrm_state_lock);
    1500                 } else {
    1501 #ifdef CONFIG_XFRM_OFFLOAD
    1502                         struct xfrm_dev_offload *xso = &x->xso;
    1503 
    1504                         if (xso->type == XFRM_DEV_OFFLOAD_PACKET) {
    1505                                 xfrm_dev_state_delete(x);
    1506                                 xfrm_dev_state_free(x);
    1507                         }
    1508 #endif
    1509                         x->km.state = XFRM_STATE_DEAD;
    1510                         to_put = x;
    1511                         x = NULL;
    1512                         error = -ESRCH;
    1513                 }
    1514 
    1515                 /* Use the already installed 'fallback' while the CPU-specific
    1516                  * SA acquire is handled*/
    1517                 if (best)
    1518                         x = best;
    1519         }
    1520 out:
    1521         if (x) {
    1522                 if (!xfrm_state_hold_rcu(x)) {
    1523                         *err = -EAGAIN;
    1524                         x = NULL;
    1525                 }
    1526         } else {
    1527                 *err = acquire_in_progress ? -EAGAIN : error;
    1528         }
    1529 
    1530         if (x && x->km.state == XFRM_STATE_VALID && !cached &&
    1531             (!(pol->flags & XFRM_POLICY_CPU_ACQUIRE) || x->pcpu_num == pcpu_id)) {
    1532                 spin_lock_bh(&net->xfrm.xfrm_state_lock);
    1533                 if (hlist_unhashed(&x->state_cache))
    1534                         hlist_add_head_rcu(&x->state_cache, &pol->state_cache_list);
    1535                 spin_unlock_bh(&net->xfrm.xfrm_state_lock);
    1536         }
    1537 
    1538         rcu_read_unlock();
    1539         if (to_put)
    1540                 xfrm_state_put(to_put);
    1541 
    1542         if (read_seqcount_retry(&net->xfrm.xfrm_state_hash_generation, sequence)) {
    1543                 *err = -EAGAIN;
    1544                 if (x) {
    1545                         xfrm_state_put(x);
    1546                         x = NULL;
    1547                 }
    1548         }
    1549 
    1550         return x;
    1551 }

regards,
dan carpenter

